Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A114B0CA0
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552039; cv=none; b=KoSWYZsfTj5RzbEbkALasqzfxK9pWC7DcyuzAKsH/5bo8VQeUlIsz9qNDU4h6Ue+Kc2LP68SJRzgkU7NmPHbQ4uom8GUIKh6UhlD1fmsjF1+9Esd+lcxEI0SiDFnQX5wTDm2V+4/V79SCYfOmDLD5mYyS4gM962cDDaI38U64Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552039; c=relaxed/simple;
	bh=kYd6c01p/n8gl26i4A8jTJYxUOESO1BYHTapBwd/wiM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGho4M3NwdGE5HndPEGH0ydrGsDqgkP4J/ymwi7g18lsue3/b+HuUj4Ol6oT3IYlKkY7kWj4e4ANEN19Ywdh0iBadiYUiX2y2iwZFuL1ZWc4un5bx+LWxY/wKpgBSGgFPncE1SVtQym2mv95FMQwuxuD9hhwfb6TA7wa2HHB2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kuBOaiMT; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kuBOaiMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788552023; x=1788811223;
	bh=DoumgsmlKEpcLHCUoqcBBHJQfndtTKJyQVDLVRpyHeI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kuBOaiMT46EYWSfp5ywr4llMlKNwl+86RV+6mzfCoKrt0aT/K39uaTOd4fQ4clitn
	 LSa2bhrR/Suxc/cE4S2KSj6H2idqbziZ6GrdvCkB5H65lmn28NiPR66yTbzyMOjxI9
	 YWIvUlnZd9BpAzxRjMIFONlb2zUBVxX/PD8Ys6L7oXaRuYVKRnP7df8XZi439kyBbo
	 FvXlwbv+WunEq7HGiV7+hH/Q2e2Ie+xyLCK1FNTX1sZzRr1ZiqEdSOJg9XwhY2VNrn
	 AKdw9+BwdhqUKRrNefPesN5F0Z/5h+eq+8nesYepHBLwAetTRGQhgtIRmXjYEdtUEP
	 Sv6gUfhyyumbA==
Date: Fri, 04 Sep 2026 20:00:19 +0000
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Cole Munz <Munzzyy1@proton.me>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: gadget: don't error on dequeue of a completed request
Message-ID: <a0cdcd76b7a6a3c841b7957a2b761ae71ceb46fc.1788549031.git.Munzzyy1@proton.me>
In-Reply-To: <2026090413-hurdle-puzzling-aadd@gregkh>
References: <20260904161344.2191362-1-Munzzyy1@proton.me> <2026090406-unrevised-stays-4832@gregkh> <7bef11b63feb88f89b37bbc86323ed3dba794f43.1788541086.git.Munzzyy1@proton.me> <2026090413-hurdle-puzzling-aadd@gregkh>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 4a4d3d905ddb0a4719c51af6bc56ba79ef178521
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dequeuing a request that has already been given back logs an error and
returns -EINVAL:

  dwc3 23000000.usb: request 00000000ad92f1c4 was not queued to ep0out

f_fs hits this on every teardown. functionfs_unbind() dequeues ep0req
unconditionally before freeing it, which
commit ce405d561b02 ("usb: gadget: f_fs: Ensure ep0req is dequeued
before free_request") made deliberate to close a use-after-free. By then
the control transfer has long completed, so dwc3_gadget_ep_dequeue()
finds the request on none of cancelled_list, pending_list or
started_list and falls through to the error path.

Nothing is actually wrong. The request is not queued, which is what the
caller asked for, and both callers ignore the return value and free the
request straight after. The only effect is an error line in every gadget
teardown, which buries real USB errors.

dwc3 already tracks enough to tell the two cases apart.
dwc3_gadget_ep_alloc_request() sets DWC3_REQUEST_STATUS_UNKNOWN, both
__dwc3_gadget_ep_queue() and __dwc3_gadget_ep0_queue() set
DWC3_REQUEST_STATUS_QUEUED, and dwc3_gadget_giveback() sets
DWC3_REQUEST_STATUS_COMPLETED. A request that reaches the end of dequeue
with status COMPLETED was queued to this endpoint and has finished.
Anything else was never queued here, or the driver lost track of it.
Keep the error for those, and return success for a completed request.

A completed request still has to be dequeued on the endpoint it belongs
to. req->dep is set once at allocation and never changes, and
__dwc3_gadget_ep_queue() rejects the same mismatch with a WARN, so a
wrong-endpoint dequeue stays on the error path here as well.

This is narrower than the cdnsp fix for the same caller,
commit 34f08eb0ba6e ("usb: cdnsp: Fixes issue with dequeuing not queued
requests"), which returns 0 whenever usb_request::status is not
-EINPROGRESS. That also swallows a request that was never queued, since
status is zero out of allocation. Going by dwc3's own request status
keeps that case an error, which is what was asked for when a separate
ep0 dequeue was proposed in 2022.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-usb/20221117054917.30104-1-quic_ugoswam=
i@quicinc.com/
Assisted-by: LLM sparse
Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
v3: cut the block comment down to one line.
v2: add Fixes:, Cc: stable and Assisted-by tags.

 drivers/usb/dwc3/gadget.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa944856f956..9ff6a733d3c5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2181,9 +2181,12 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 =09=09}
 =09}
=20
-=09dev_err(dwc->dev, "request %p was not queued to %s\n",
-=09=09request, ep->name);
-=09ret =3D -EINVAL;
+=09/* Dequeuing a completed request is a no-op, not an error. */
+=09if (req->status !=3D DWC3_REQUEST_STATUS_COMPLETED || req->dep !=3D dep=
) {
+=09=09dev_err(dwc->dev, "request %p was not queued to %s\n",
+=09=09=09request, ep->name);
+=09=09ret =3D -EINVAL;
+=09}
 out:
 =09spin_unlock_irqrestore(&dwc->lock, flags);
=20
--=20
2.55.0


