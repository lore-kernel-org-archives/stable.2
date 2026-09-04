Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BCD3B6C0A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541160; cv=none; b=VDdpcA4h6D+mxnbkl7x34rBLAXDvNGgLuYVmIr2LcjcDWY6KymSQjsOgVGkKZ84O4xwqQK0qP6R0OEevP6VYd+BcYFexc+A+j2YhnUS8lRi36RoGBVAkkQYR1jt69XxcGtefbvylD9T412VVDxdyj2vkkKaIL3cMKRR9niYQ1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541160; c=relaxed/simple;
	bh=o9Q6bSxOywdc7gF+cE+BCQuIJUchKN3az3fgt5KoPWY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGvXVx8g59/jY5ruVgvs+TLDM7dx/zM1jrnOA99tK5sOG6H0BPkDoGPjS18P7MLItaTTyRhMgr+JvsuzwCT2aFfL+mHCygdwXW9xgajCIAk8QWOs7SWqPSziBGmhOufTcyOM35/oCrCrfDxVpuST7OwdISoFCtTt7eWDSqnz5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Hq7sWd89; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Hq7sWd89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788541148; x=1788800348;
	bh=DSNbEdW7Jvy+2LDd2zlNN7BRgqvrqs518O/OJb2Se7M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Hq7sWd89bvWNlHoJ7+9RO1ndSmN4ebuMzzNocWnbPE0QOIJkY3B+MaDZMmp1DkjCB
	 L0ojTXbua3aCPMeDWn/SWa+bc3dQVZZPrpD4aUChnFI6cVQW99BlJdXOlVyQ2d7R4+
	 qRMTc2iRATabkyE/hmEWK595mVQmIsRTZNZixBKeWzRBlJql1aXtKBHDig82chVgW6
	 +bCxrHqtkOdj0QT3u+mgxtUatD/HLTjE+zGTfPYkiY5rmgiJrCLeXOL9pHAY0pizuk
	 mnZO/B4ZHMmpHuHEI27QxGFEIKDza6H1R80zIte/e2vEurtgzUOwtKVN1WGUJQo4IT
	 kgOe2Nxx6azPQ==
Date: Fri, 04 Sep 2026 16:58:57 +0000
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Cole Munz <Munzzyy1@proton.me>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: gadget: don't error on dequeue of a completed request
Message-ID: <7bef11b63feb88f89b37bbc86323ed3dba794f43.1788541086.git.Munzzyy1@proton.me>
In-Reply-To: <2026090406-unrevised-stays-4832@gregkh>
References: <20260904161344.2191362-1-Munzzyy1@proton.me> <2026090406-unrevised-stays-4832@gregkh>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 47c0cd66bb113c2f63ae6620b0e6fc449b32e129
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
All three were missing, sorry about that.

v2: add Fixes:, Cc: stable and Assisted-by tags. No code change.

 drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa944856f956..f68eb9254afa 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2181,9 +2181,22 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 =09=09}
 =09}
=20
-=09dev_err(dwc->dev, "request %p was not queued to %s\n",
-=09=09request, ep->name);
-=09ret =3D -EINVAL;
+=09/*
+=09 * The request is on none of this endpoint's lists. That is the
+=09 * expected state once it has been given back: a function may dequeue
+=09 * a request before freeing it, and f_fs does so unconditionally for
+=09 * ep0req in functionfs_unbind(). Nothing is queued, which is what the
+=09 * caller asked for, so report success. Any other status means the
+=09 * request was never queued here or the driver lost track of it, and
+=09 * stays an error. So does a completed request handed to the wrong
+=09 * endpoint: req->dep is fixed at allocation, and the queue side
+=09 * rejects the same mismatch.
+=09 */
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


