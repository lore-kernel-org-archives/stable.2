Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994058;
	b=PgiRfkNyI/5CKgORT/+1bYnmlrXRix0va5q+0V8t2Kf30sPdGt6qcc0eEsgjdWatcvVb
	 d57WPEoexQ3b1Fy9qkex55MidlJc4P1ECqr4X/Y5JLjag4+G8H5EHnngJbsfE4feeQstp
	 /zeALKx/wBAHMk0QuRymLRHO0nJLpUBMXZog88nZP4NIEIcSXsUgFmVryvzm+eqQTB+mm
	 ZvV+k++N46f/7147/Nnl3XV706peQvsi6PQlNUCuZcNJGSu+pLBBC9UM4z/WuLRb2WZBm
	 v8jImEQwUUaocsv0KDhlvM3nSeg4GfqlBIHkGUuClbpv6MFyAlLA0yXt03Vn5Snjj/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:User-Agent:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lItl7Ks3Ko4mpofEkC41Hng8AAxtpjFcDg8vOTtiDX0=;
	b=OI8GPNTi9dIn34j0n4TeI9/xij1wccuryVUkISj3AFsD7A/uX1hi42s+bddr4syccNNe
	 HZFAb0c6FdxJtwnEXjLtexNSu2FM9CPtuIZBZL959brWNsx5FjUM6+zHDcYcoYiShuGhW
	 6qk6ePPf+WHwMioJ+8SA7Sega8mUnyDfEBoa7VZ6jGTb4n1WilwfduI3FCEDAG9Ho9TLq
	 B8wYFEcw8zGM+CjTLesgjgz36xVKP86ubwa5fEI5OCW17r9lZUoDe/RRLHuVta06U5fwd
	 qEkCmzoDUmcDhkfEjhEFujKSUw8mBPIia8aCRpjObFxxLW7CGcR7PFKWLzbq/AYlVjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYGwVGrP;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40C606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D40C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYGwVGrP
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1643341eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994057; x=1794598857; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:user-agent
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lItl7Ks3Ko4mpofEkC41Hng8AAxtpjFcDg8vOTtiDX0=;
        b=lYGwVGrPHdswComoR/WYOn83ZRLgSC0gUdMbJ7VvvuwEopi+l/+AhzGKpBvOdnU5I3
         ZFZ+vJrdP8s6i1IZDNYvc5FfKe5snxeA6ZJu+FvJ5EO79lfjcBxZO0Vnn8E4xk+xTNdV
         4Ca5sXwz06lkq0t1kiHi5HzP3lHgKi0Fvi6ejn6ryyNB4NoynkOGSiTzH1N60VF1xqdm
         LB/hYxIjaC57x3UMCOBsTOwxwC70fZiwv7x8jyBVt07yLLyNMMhTqFY4r2GHmGGwa4GZ
         chSPW+hZyrzFtb60FUQDGO/rntRxB/IDcIhlJGk0/kGw9sJLO0SKUOFQIA25P2nhHCUC
         mGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994057; x=1794598857;
        h=mime-version:content-transfer-encoding:content-type:user-agent
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lItl7Ks3Ko4mpofEkC41Hng8AAxtpjFcDg8vOTtiDX0=;
        b=tYSRhs2NilIqHQuUu/nHGFeo8nkoo0ZBzCXiVdhlIj70+pQvF/2JOAWdW3n+37IOgn
         C4wW4qPjvDEu0NyACLRM7A/khL6J0LEr+nHE+ju96ydRTSaGFqCo0SQ7wnhdKQpx6/kP
         Y1DIulsDxhQ5/buaszDA1hVT7+l2vKTAY1fqTidNfZmyrqVwFLNdyWNzgsGZBnCA74Gl
         hA3sMFv9xVLbb8ngXIIRCrNKNwmlzVXO4GMs4gttj6wVMWrdlJIgM96p8E8fsnAeqHVs
         hWc3KZ7IakwmjB38nobCHI6WBkvVhxUG8+O2JR6U+lXTr6wvq772rUwpbhspBQiz0QuX
         dVJg==
X-Forwarded-Encrypted: i=1; AKwUvByCodzrFltYHEh3HnyGfwVR2o8N82O6WofutaASZpatn6h9V+Ae7KTseZ9DOCBsJUCEGf0BXw8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9V6BdMm5qqlmrAhobsqwInVqyDdzruNhrJjbkC10od39uPjWZH
	QYCOmLKlFDdCEoFz79QWq9ISHAhOU3jJ3RvavxX/ealJVF3osKOA7LAG7JQkkT+v9ytnaw==
X-Gm-Gg: AYBFou36hPj/eu23EJ3Nm6NzEFYVxq3rUGeLhGyU1tz2tDyfaL/CM5SHROWbRnC5jpo
	YQyWU9UTTAuE8fxLKGFcQpRt8w1s/ms6Ms/f9CcUWZ1TGyohaV2wlTr4QYkfxtH+ZvgEulRmQ4s
	uKYsjzfXIM46QWeZ3IA0rL4fQ1kCHfDu/zwVX+IAJGmcIJig/XTIBBoWWxVQTqO784AX5xv1TQ1
	C2HQu3znkI5gs43GT6qy39MqAjgMJe3LjLj+V5RsIcjlExLZ9m88xJdm8lz7+1dq47ib2+vlp/E
	9t1NT7ki7E0WC/LKAS+UiKrTrAAUmXBlW37zpSV++2NnLV/P3hYhuGESvsIGDC9jUtwZXcJ+b2T
	9PAfSQ4CBhpclPCKubjK6pxl1PgS+v8i/MQ65Y8/TAbfOXoeb+1BF02ocELrS+Q4fPzYnEl0B/Y
	hlpiSHFUHe0WRXv1gIUxRrPMpH65FwN3+pPTOgWR89rkJke9KVgZgqiD+jxhFpbq5OMo1a2hn4E
	kyj/iLo/Bfsj2+6cFBHUuJCiNKthrDzZnJyic36x7NrrOlME4O/g3fXHGVDPMaqq3GpBkV7wvW5
	MZ+xvjl7DtYyr1qZDfgfKdc=
X-Received: by 2002:a05:7022:286:10b0:143:6525:f9f6 with SMTP id a92af1059eb24-1b25d2f7929mr4156861c88.13.1793994057316;
        Fri, 06 Nov 2026 11:40:57 -0800 (PST)
Received: from [127.0.1.1] ([2406:b400:21:7ec1:90d0:3395:e0de:2d21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4c1df6sm7788930c88.14.2026.11.06.11.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:40:56 -0800 (PST)
From: Vishal Tyagi <vishalxtyagi.oss@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 [PATCH] Revert "Input: synaptics - enable SMBus for HP Elitebook 850 G1"
Date: Sat, 07 Nov 2026 01:10:52 +0530
Message-ID: <179399405216.85438.8327280593401118083@gmail.com>
User-Agent: git-dispatch/1.0 (Linux x86_64; git-send-email compat)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

This reverts commit f04f03d3e99bc8f89b6af5debf07ff67d961bc23.

Commit f04f03d3e99b ("Input: synaptics - enable SMBus for HP Elitebook 850 G1=
")
added PNP ID "SYN3003" to smbus_pnp_ids[] to enable SMBus/InterTouch mode.

However, on Haswell-generation HP EliteBooks sharing this touchpad controller
(including HP EliteBook 840 G1 and HP EliteBook 850 G1), the touchpad fails
to resume after ACPI S3 suspend:

  rmi4_smbus 0-002c: failed to get SMBus version number!
  rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
  rmi4_physical: Failed to resume rmi4-00: -6

Following resume from suspend, the touchpad remains completely unresponsive
and dead until a full reboot or manual module reload (modprobe -r psmouse).

Falling back to standard PS/2 mode (via synaptics_intertouch=3D0) allows
multi-touch gestures (two-finger scrolling, tap-to-click) to function normally
while preserving 100% reliable S3 suspend/resume behavior.

Revert this commit to prevent this regression on affected hardware.

Fixes: f04f03d3e99bc8f89b6af5debf07ff67d961bc23 ("Input: synaptics - enable S=
MBus for HP Elitebook 850 G1")
Cc: stable@vger.kernel.org
Signed-off-by: Vishal Tyagi <vishalxtyagi.oss@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a8e2a14..0d1b54a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -195,7 +195,6 @@ static const char * const smbus_pnp_ids[] =3D {
 	"LEN2058", /* E490 */
 	"LEN205b", /* T490 */
 	"LEN2068", /* T14 Gen 1 */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
-	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3015", /* HP EliteBook 840 G2 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
--=20
