Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645737;
	b=KqpmOpdch0sJtd9bcrvtXOtMamh0zZS0H0L25+smcwQgFmDREtHMryfJ2tMekXEeGuA7
	 pLZZMZlW35pADasOR5wkRpU7aubMtuKRAptrL3reEW6q7hP187inGXBNVJae6TLm6UnLn
	 k4iMdo1DECwuoZ9Se2K9QLnPoGZV06U9Aa/WgTKktMDPLUU2FmukZX6Q6/VIS1wBUJ2yf
	 grfCZ9+bfiI0Y+onXBl9wvBPw3ykhlCFG/ME6bWh7F6n5pz/EwXWM88FEL37z+u/zy8Yr
	 q9DvtMj9yRWzw7ASor8bxLK6fwZZb5Wot22xvkBoeUl/AaxYOOi4jZGItgG5SsUL8hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+G+uV6wn4dA5VTXmYb7jbew/KoHfSprRvHUbv8X9R3I=;
	b=OJBVR3KbGPR/5M7HQ8PJAzcObCUI0T4S4Tb9WoewEtqXYSZgDd3f2iJygPm+twYLrv3i
	 moqPt0ozS+ETFaiyFHp1w6lxONOus4h3St0LZqOc9OD422YnFYBNBHrPLFmISygH1j3t6
	 MDH6rDGgcjYEfN7QXGXsJAZ+waMFnv6SWQsBDDzdYe+7MYkFH1uySemHSLnIyVtFEflAn
	 0KYB9qxMK25NNFvyKQLk+0WxWKl1536rgZG0Pj5KkkQyNQkreIA9Pfx5Cgel/Tasv13X5
	 r9fo1JEiL7ayGKaVmHHGzc+2xMGDwYIpWwXZQ1oHbApE57Tkzj4tlTpb1OxSz+OvDHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XNSc7e5z;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9A606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D9A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XNSc7e5z
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b588e4bd7fso1382354c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645737; x=1796250537; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+G+uV6wn4dA5VTXmYb7jbew/KoHfSprRvHUbv8X9R3I=;
        b=XNSc7e5zwWvVgX7i4Of7++EHH3p/niveXhLkX9RmyD7j+lqq/sGmx6rMj6R3sy8sEr
         8m9De3+5Oolw00oVly9q1B9bjKyVWLuqSb3jcAL0ZIZ8824rFezMv3mih0zeFZai8JNL
         FXb31CSxTtr5DcbGKsVuh0UOE8BoB3Fzx+5EdontHWm32aq1d5n0yeGEpQu1WFgqVyK2
         C+A2GYYcv9kgSlPI4pOdiISaySsU73N8J5LpOyr/OZ5CuW5TsoJ643i16HjFMPK61BpX
         vJLgEU4hVn6KMSGc3BIO1X3TxjOQ9+0tdH9einkwsN0wu2UJeCAE9BCqhwrsWpzU9T9l
         tFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645737; x=1796250537;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+G+uV6wn4dA5VTXmYb7jbew/KoHfSprRvHUbv8X9R3I=;
        b=gHfBpTiDsluLrAqjXQREHessiz5FmOfwmDM+6+stE0Zh/Y/7uun1dcIm1X99sybsIA
         59u8Twnq+2vBJgozj8rfNM/Y7jqz42qPcOspoIM0zKsTLAkSrQMEkP45sO2/IAtmkGN3
         2jxyx+HRLz2dFPD93hUYg0eYSdQ4jnQA9oUmkz2pameVEYzogfzULR6sdRWA+WO5y84S
         CkVSaz6E3Z1fp4JHSi9Genp25X16btaTj+84axaJT891YZ7uaewue5WMgAImY83BLwVh
         yQcnIyocVAIEjMKub2uJNJh+hUnoIIye0HeVELE6hU4US9pOQsjAWjNfFQbnqKDHZ2E9
         TWdw==
X-Forwarded-Encrypted: i=1; AL+hErFl0nwcBjJa/gvBZPimnINrvWRN+o6myUKskJ++CGBo6jRPOpF9kTyW7Q3mHiB+doaGQ8w6zMs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uezt+Uvpe4Wmcd4ChNl6oYVDnWSgydkn/perKQaDIE5A9mxHL
	nvxvyf33VHZeNsV7HCl6exF8zXdPiyUqEOxyLupm93T0Hyw7i7SIEulibyV+aVLD13gdp3A9so1
	mNg==
X-Received: from dlaf15.prod.google.com ([2002:a05:701b:240f:b0:195:cde8:ab41])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:8148:20b0:1b5:227:7d1f
 with SMTP id a92af1059eb24-1b55689eac0mr18892001c88.11.1795645736109; Wed, 25
 Nov 2026 14:28:56 -0800 (PST)
Date: Wed, 25 Nov 2026 22:28:27 +0000
In-Reply-To: <20261125222828.1452483-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222828.1452483-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222828.1452483-2-elkin@google.com>
Subject: [PATCH 1/2] usb: misc: usbio: stop resubmitting bulk IN URB on fatal status
From: Elkin Cruz <elkin@google.com>
To: Hans de Goede <hansg@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Antti Laakso <antti.laakso@linux.intel.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

usbio_bulk_recv() unconditionally resubmits usbio->urb in softirq
completion context regardless of urb->status. When the bulk IN endpoint
encounters a terminal status such as -EPIPE, -ESHUTDOWN, -ENODEV,
-ECONNRESET, or -ENOENT (for example on endpoint stall, disconnect, or
usb_kill_urb()), resubmitting the URB causes either a tight softirq
resubmission loop on persistent errors or a wasted submission against a
terminating URB, and zero-length completions also inspect stale
bpkt->header.flags bytes.

Return without resubmitting on -ENOENT, -ECONNRESET, -ENODEV, -ESHUTDOWN,
and -EPIPE (matching usb-ljca), verify urb->actual_length covers the
packet header before checking USBIO_PKTFLAG_RSP, and log unexpected
usb_submit_urb() errors.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/usb/misc/usbio.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/misc/usbio.c b/drivers/usb/misc/usbio.c
index 7b5f8669aee3..6142a32c18a9 100644
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -239,17 +239,31 @@ static void usbio_bulk_recv(struct urb *urb)
 {
 	struct usbio_bulk_packet *bpkt = urb->transfer_buffer;
 	struct usbio_device *usbio = urb->context;
+	int ret;
 
-	if (!urb->status) {
-		if (bpkt->header.flags & USBIO_PKTFLAG_RSP) {
+	switch (urb->status) {
+	case 0:
+		if (urb->actual_length >= sizeof(bpkt->header) &&
+		    (bpkt->header.flags & USBIO_PKTFLAG_RSP)) {
 			usbio->rxdat_len = urb->actual_length;
 			complete(&usbio->done);
 		}
-	} else if (urb->status != -ENOENT) {
+		break;
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ENODEV:
+	case -ESHUTDOWN:
+	case -EPIPE:
+		dev_dbg(usbio->dev, "Bulk in urb terminated: %d\n", urb->status);
+		return;
+	default:
 		dev_err(usbio->dev, "Bulk in error %d\n", urb->status);
+		break;
 	}
 
-	usb_submit_urb(usbio->urb, GFP_ATOMIC);
+	ret = usb_submit_urb(usbio->urb, GFP_ATOMIC);
+	if (ret && ret != -EPERM)
+		dev_err(usbio->dev, "Submit bulk in urb error %d\n", ret);
 }
 
 int usbio_bulk_msg(struct auxiliary_device *adev, u8 type, u8 cmd, bool last,
-- 
2.56.1.839.g22a8290db9-goog

