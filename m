Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966667;
	b=mWZChMsee1Cpg5s0zOtorvImHep3y5/AkhzZ5jpKSIh4oGsXZI0e38UGnfzW56m1e7VT
	 OuAJFW1iHDvCjwu1qIryIdEQHAd9FnGfNa3uvsDXDbxsRl/YpN+Qxb9ea6m4qlxXGCaA3
	 84Nx9GshI5hFCJO3d6boe4Ia8eIQSLpPnjLp8cHiljhZZg4EGlFoeaz1JQ2KYejgXVHJZ
	 ot61KHS0AK71EQ+7yDPgBWTRxfCqoAPo8Sb87tkEB9NxlcR64K4eyHi7t+/DaPcnURtf0
	 f4sEq+0WbXsuwQshOpAOz+ZRjrCCzgwAc3tv5nsaLmKNDcNsbwzLEWmLSE2bgRrxKFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P1OMG/B1lVqgZxM1GZjWM6eenEu+BEzraRxEM+z0u2A=;
	b=OfKcmEXF4eartsPWqX3RxivYCwltirZGMbMHjGKEUeODJyQbCTK1lCRX8NdbgIpLOT4f
	 L2Cj+E6lr3zi9mpD45XTvw8zCIME4E9n8X9Ty5h8qkKHOwwzBWng7sRu3l3DrJ5cL7ArL
	 L2Mx+rChZGqAX7G2opmFEpBoumZYAvKqG4El4D1ON1Bi3061jpT24/DRmj7seweNylWxq
	 5Wjf2mOvT7GzUDNjlO9iysNeqGnPLotW2Pf0Hpq+N+o+LLhTMADBx4XpfgjV1dow3OoI5
	 wnMhRI2Ptu4aSyR3yyp9+WBfqXvGS17Os3B+EddNmGQZODosLugKPtxtE/mwE9fCTJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJ5DVKWL;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D68606A339
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D68606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJ5DVKWL
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c450ab1483cso86429766b.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 04:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793966665; x=1794571465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1OMG/B1lVqgZxM1GZjWM6eenEu+BEzraRxEM+z0u2A=;
        b=xJ5DVKWLdsqGYUj4mBLEzYwT4ZfyRw80Pr3dR6mVmfZ2qrKdrEj0P2Ev+90MvMbeyR
         fr/CR0GbJCTMdBd3vdDH5q84uNemVDCluDEoiWRoEis2P/deHkOkn3Xd8xY7DFovRntM
         EjQYE5OSOVZ8hi1kDghiMRg3bri/s/FPFcvFY9Cn7gfYgwc0C0TwCi5K2mUdPzhImMJ2
         43eqptqFyRwStcXDo55PV9iOzDWloW4mR9WNbayt031LkXwlpBZ1VjCZTVLgoijV6EK3
         sHNmhiwDZfezljtn3m4HEwXEEytX8/P7CU3r77pvcuBj3OMp76NJQu+R0VmOR1Q2QXAF
         7ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793966665; x=1794571465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1OMG/B1lVqgZxM1GZjWM6eenEu+BEzraRxEM+z0u2A=;
        b=S24+oZMhhDY9riDFX/SK7RMajeLYO5u2fEYSo2JF36mGyk4yzrJKv/7Da+Tp1hsDAG
         hi413fOBZOvmLLtHUPGP4oSuGaz4YT9LsK8ZXQmmNPtp1BNAXl/LkXxj29J7DMnWqalJ
         69qjs9fU4jk4pjFKiKJKdjvb36CeUjcLFgExy/Om+qdZu/IiMOaM3XduJaCHmtrIdEZD
         s/0O/iU0KP3zypKjdphXRlYrHFXgRbcT8n5cNVnKd+sl7JvJIoG8RAwhM42CNeYqNhjE
         jQUcKMxJ1hUmyxGT44y9mzN+MoFRcONVkloNsyu8e+QsLYuXtDOXn58xNN4ZAJrJEBtC
         KwPA==
X-Forwarded-Encrypted: i=1; AKwUvByVarIDMu/mkfE3oeJJdrTuIQeIItgZr+OybuD8QgrwzevYgiV/jEIwkJCSr7HDgmEQV0tm/WM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I8o6HMOD/wHW0nn6YKWBayTUpdBo/rrHTwbcpegL+q7gKIZcI
	DGYZKJ/6ef0xfx+1tuSGbnwmqB7OUC2nPV7El6PlTL7TknRFAKPYdqQD
X-Gm-Gg: AYBFou3xk1hoAKK7FOQoKUfKRli/n5mtzTRCDPKdvBVoSICydCFnJSEdstS1VzNccOc
	7dYserfXrgdXY/bGRsV7tHPCRKJrFFHtXKiwPxMwhfo6Hr7N0AKX/cop3RcqkRKDJNvhZmI2a0Q
	kmtwljpcD2tYlJ9q7kilQj8qearMYNDez2y7DWuFQwPPEg6wynmix6r3yCnd+M3l8y/7Z3TMXKH
	S4u1Jbq3Y/EgbtVXFT0YRCBJIPth4y703tkBeq31S6FLLe6QK/np71tLdz29ye9P5xoEnu1PcAU
	ICTzHLYZJ3xjVRtPZWwfQyIPVwiVuj/W6X6vOssbVBjWx/3rbFtL6ojQg/sig46jPF72mn1l7No
	qr+XlZFQar6mtSYPMsA/os1kXyj2ILDvhFCQhtc2k2EL16DE2oYxYIPKToe9eA8yM8sPr5Qpo7I
	bnWtztj8N2/OWuzR/+FrkS90+tnFkAznCzLciO44/ywezfoINj3wsprP3VfflgnwFS/cWJy95Or
	fMNgEa3EXBA/W5vEPuWja1breVeDT5wBJqGtA6iEphy+yAss7Iw+2fk4igc6GEZ1kDete/mfTY4
	fyXc3gMCGmw9cZf00S4h7g==
X-Received: by 2002:a17:906:dc8a:b0:c29:f5d8:9c6c with SMTP id a640c23a62f3a-c4d3530b51amr205452766b.27.1793966665069;
        Fri, 06 Nov 2026 04:04:25 -0800 (PST)
Received: from beelink ([186.247.163.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c60b0sm73922866b.69.2026.11.06.04.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:04:24 -0800 (PST)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] HID: wacom: avoid divide exception in dropped-packet calculation
Date: Fri,  6 Nov 2026 09:04:05 -0300
Message-ID: <20261106120405.169399-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com>
References: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dropped-packet calculation uses a modulo against sequence_size
(logical_maximum - logical_minimum + 1).  When a HID descriptor
declares a sequence field whose logical range spans all 32-bit
values, sequence_size wraps to zero and the modulo triggers a
divide exception.

Replace the division-based calculation with a branch that computes
the forward distance through the sequence range directly, as
suggested by Jason Gerecke.  This keeps the existing int types and
avoids the divide-by-zero without any 64-bit arithmetic.

Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 16-bit")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v4:
- Replace s64 arithmetic with a branch-based helper that computes
  the forward wrapped distance directly, as suggested by Jason Gerecke.
  Keeps sequence_number as int; no type changes needed.

Changes in v3:
- Replace raw s64 modulo with div64_s64()-based remainder to avoid
  __moddi3 link failure on 32-bit architectures (i386, arm32).

Changes in v2:
- Normalize logical_maximum/value as unsigned when logical_minimum >= 0,
  matching HID parser signedness. Store sequence state as s64.

 drivers/hid/wacom_wac.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 361738b..1d3ae94 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2426,6 +2426,13 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	}
 }
 
+static int wacom_hid_wrapped_dist(int after, int before, int min, int max)
+{
+	if (after >= before)
+		return after - before;
+	return (max - before) + (after - min) + 1;
+}
+
 static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -2551,8 +2558,11 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 	case WACOM_HID_WD_SEQUENCENUMBER:
 		if (wacom_wac->hid_data.sequence_number != value &&
 		    wacom_wac->hid_data.sequence_number >= 0) {
-			int sequence_size = field->logical_maximum - field->logical_minimum + 1;
-			int drop_count = (value - wacom_wac->hid_data.sequence_number) % sequence_size;
+			int drop_count = wacom_hid_wrapped_dist(
+				value,
+				wacom_wac->hid_data.sequence_number,
+				field->logical_minimum,
+				field->logical_maximum);
 			hid_warn(hdev, "Dropped %d packets", drop_count);
 		}
 		wacom_wac->hid_data.sequence_number = value + 1;
-- 
2.53.0

