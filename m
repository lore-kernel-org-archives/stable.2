Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4452FE060
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335934; cv=none; b=LqShoKhzBuaFvReR/aRdmqLtde0xVUKSlyN76b97iRjwzebKJd1Y6dw3FjGk85Mq+iWsghZd/C0Ho8XvqLSNrePzwVDB0tOkDrHQ2TswSW9I3ilPL3TvDz9Q8hoqinD2vPLrE7NggQt72YFZ89WwbJTBSwggXW+feP+NeAsrmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335934; c=relaxed/simple;
	bh=N/N75PTpR6eje2R7nmSe0Hk72+yIz46S4Yy31gQvFhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz9mLR7ZvFK0W7ul5zy3mPCtFild0qnUR0pJ7tPI0Mhr8Dw8yhejddWCwb7HakMENfRpfqjR60Yy0m2Uq/kC63npR38vof8bL3qJ5WPdQRr+L2wl77QK3eKdSMcJPYPLml9JLwQ0RgLRWFEPfKTlYzYNGaknxBrK4Vj+mU0pvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPSP5Y+3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnPuDKYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPSP5Y+3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnPuDKYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789335932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WV7NW23j0Upl0DBt56PnTdjoLnNEhTrt48kDmiyvSlI=;
	b=MPSP5Y+34IWKPSVYN6EQ5ew+d42FtqoxEgb9szBPxomsQbMY1pujbeBNPdkWbMCgvn21Kr
	gtEfJBBuz/50bElkM49OvXvMxPbFrd8viC7d6pUHFydQOXwtCjsVMkpyO/HvfL62PwYoJT
	FAzbEm8iVDkcZ7gd3+uM/hd/7IVUnVM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-sTN_bO2LOYCcgLyXpo8Tdg-1; Sun, 13 Sep 2026 17:45:30 -0400
X-MC-Unique: sTN_bO2LOYCcgLyXpo8Tdg-1
X-Mimecast-MFC-AGG-ID: sTN_bO2LOYCcgLyXpo8Tdg_1789335930
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e7de22fddso60035976d6.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789335930; x=1789940730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WV7NW23j0Upl0DBt56PnTdjoLnNEhTrt48kDmiyvSlI=;
        b=OnPuDKYZl8vpEJKbIubG3B1Z1sGgsHqQiRmq8E5m6mjLz88Ol+tXWwnJRjhcWagJYp
         Rrt2tJhq5cFgM601c/3dhWSNcA49SylAvOFmnoRtdsm9UecYbbn9vDsp8fQMeTMklsh7
         aAldiLdA/W+BtV70gJ5sT6gHYS4NurU/HIRVmjXAZ48nDwPRmQ2cH+kbRbKgOD57s5tZ
         gmq8HsSm9YCjUvJwy4MmzwQF5Ct4lZk39kVe1R3S8l8fogVC3UWALdriABwscOv4+6rG
         X12COCWopIiC7THz1VgDu1hiMOv+wlVUjhxDHNanexSRmHT38j7zF3znNKSZx5ZEvGB5
         ESFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335930; x=1789940730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WV7NW23j0Upl0DBt56PnTdjoLnNEhTrt48kDmiyvSlI=;
        b=hIsaRlyLU51jn6m3OL1k9V6mp2ejLpf0ra05y+rvnAdZbP/vO4aJFx406bg4710rh3
         95LPJvdDKAvONuWotJwSS6DjaDIdi+V0u7+29Ovq3zbRrKwlPqSOBY+Z/OmtA3cBEXTg
         M7I2WJwJP62oKBdZ8H0lu42kWtFh6PY+NgwPzMm640pPG5MOc3m2AVD+Oyr9T4bGkX0I
         b/G9D9MGKdDEW/aZzt7drBQh3fdQZYb/B+sjKB0h3lwhJpW77GbwVhfnc1CI4/PPyBR3
         lEo/3oeDvW31JyK75H0Ehj/NN4OO3t/XvbXo8YFJ1LW3UYzJEg/zE+Pn0Mzqh8s0bU4Z
         duNA==
X-Forwarded-Encrypted: i=1; AKwUvByUkvIb9/HlKQJPkg0KRRQEBlx7c+e0AABtQcjmkEFYmuwu/lm3kd6BXZ4DrJVfhD5IjDPrNPc=@vger.kernel.org
X-Gm-Message-State: AFuF++niGPeVr7O5UBUU4TGDEhsn76Onb9d/Bmn3IsMYjS+grOVQbe8U
	RbSdAAAY1uorP2zj9X1KHEuu87UNvoSu+phrVFsc7O01Zlts3JfEuEriAvnaE+mKD0ABfoFHLEy
	8KhNZdd8bDAa4O6gDxDNpqz0Z/hiGDdVmI5+RXRXOQaPhlZRGeF8CP0FZgnmhYIBIcQ==
X-Gm-Gg: AYBFou2Y4lx5bw7exzTHqc0urZoPfYMWA3Rxt/1U4q5NscrXdBeM3DdVv56+2h3YCGp
	U/n1N6enLhfw61G10Z4qSyN9ZXz8xKC8FTCMln1Q5FmMyYWyo589zUc0BVZwHXtpwZucVcaIBko
	hiHvbw37uik7dipSNhQ972h5aUP+I0WTXLnyGXRCuPvwFbcM4vvYMh7MHZ0ay6G09RC9sFYG353
	TN4jSfXeI0MKKGnr9FMdJJMbfy8oA/SgqpjBjW3V13sCL/6bsszK9xpNwEZ/RxC4OR6+DKj4CWe
	Y0nTJFF6C9GSi3AJOBdhTo7rxUhyl7i7sNQ1c4RXvVi26PPl/cvyHtMlZLKYgRL9lUH23L1CfEA
	E9O7Z9ysnQOtRgo03qC+nT7l1Ma8Gh2ryoqU0Kp70PUkUZLA7HGLFc3xaha0mlSYdZA==
X-Received: by 2002:a05:6214:1315:b0:90e:9a7c:e5a0 with SMTP id 6a1803df08f44-912120f0444mr213951866d6.17.1789335929968;
        Sun, 13 Sep 2026 14:45:29 -0700 (PDT)
X-Received: by 2002:a05:6214:1315:b0:90e:9a7c:e5a0 with SMTP id 6a1803df08f44-912120f0444mr213951596d6.17.1789335929572;
        Sun, 13 Sep 2026 14:45:29 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f49444bsm78581126d6.29.2026.09.13.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:45:29 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org,
	pc@manguebit.org
Cc: linkinjeon@kernel.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v4 08/10] smb: client: fix underflow in is_valid_oplock_break() notify offset check
Date: Sun, 13 Sep 2026 16:45:06 -0500
Message-ID: <20260913214510.3071370-9-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913214510.3071370-1-sorenson@redhat.com>
References: <20260913214510.3071370-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bounds check intended to validate data_offset against the received
frame length:

    if (data_offset > len - sizeof(struct file_notify_information))

suffers from an integer underflow if len is smaller than the size of the
file_notify_information structure. This allows a malicious or malformed
packet to bypass the check and construct pnotify using an invalid,
unchecked data_offset.

Fix this by explicitly checking that len is at least the size of
struct file_notify_information before evaluating the data_offset.

Fixes: 097f5863b1a0 ("cifs: read overflow in is_valid_oplock_break()")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/smb1misc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1misc.c b/fs/smb/client/smb1misc.c
index cdfbbff24b72..a39c9140ceca 100644
--- a/fs/smb/client/smb1misc.c
+++ b/fs/smb/client/smb1misc.c
@@ -86,7 +86,8 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
 		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
 			data_offset = le32_to_cpu(pSMBr->DataOffset);
 
-			if (data_offset >
+			if (len < sizeof(struct file_notify_information) ||
+			    data_offset >
 			    len - sizeof(struct file_notify_information)) {
 				cifs_dbg(FYI, "Invalid data_offset %u\n",
 					 data_offset);
-- 
2.55.0

