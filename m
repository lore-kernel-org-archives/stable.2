Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990619;
	b=jTlrnkoWwb2HR/3EvEDDfwzmN2rZxNOBSF0rUZtVNbCFPYmGtJgO0evdroQ0ylgBhH32
	 eK9JzbLn7ucal+YCWVdNaiDLQ8H1Xns0LBQi6GhaqcmiBwgbFPTnXkSduAXi82YCObOUa
	 /ZKWCZjkxyuLE+Ch2ztQKTUL7nA3fcx86cyMvlWxAk0BhWddJQtWkSflJpynGQr+K9zvy
	 Rg0ZObY3nZnuhNguhNyPf4Db66oD2t//lDJUjbhFT647DXs+MmAWjjjvHAZaJEWlmV+/Q
	 mbjbc54MTYzO4Pbq2MtALkHpO3z5kCqmQVZFWCQldDWVSb9fihjzR0isb8VHOPol6wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5QKJmKMjkfOGpFABXHpSYbL0DQQPz9RbFTdkuxGPANc=;
	b=I+PdcqaSMuCzkFh5SaOH2fZvstQ+oPXJLxpxTr0FQjuRKSIo/MuJpFzkcHU/BTiMm1cr
	 TOdeZM+kgHvZ6Hym9hIRzLNZpyhoEY98katuUEoGMaHrqwa9BdzWH5pbkcVMCTsey41Mn
	 XnWsyGCRA7Wviznib6LhYlW2HoJzsII18AasbZw+1olIzFahX/xE6xHLUrCrtqNX3jOjm
	 irJwrv9pvXKZnDEiRxYIdSleltPtmDaDDiPLyZscIYatkBRsST8WlV1rVCM3bsAUD8VHK
	 ICkDf492glZRvRRNXHkmLW59s6TwcKijDmi/S2fl1udSV0UgO/EGO6oTZR2JMPXhzXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ie83F/uF";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0867606D80D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0867606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ie83F/uF
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3282db206d3so1981174eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990618; x=1794595418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5QKJmKMjkfOGpFABXHpSYbL0DQQPz9RbFTdkuxGPANc=;
        b=Ie83F/uFyrVvA0/rLV0W04tYhHf6e6Cpe7Y6MzfUmnHvUN6DPHPiDadmgPBq7S1vw9
         Ti/H6+8h1/yQczrluJ9FOmwKR1ZBvkWm+5kfCom6MegrpnwGxpgq/qvkkZ5Y9Hmra3z9
         mdnMi3gWUsLNOvEIK5EgSgWOmF7029ojTahMe3ehiyokJ+zXDGPVefiDLNVfk+bqesOD
         SXKwO8WgR78UJaDk5lPBD8xr25XyztL/eiuNh5V9nxbsPr2KssLVh+B8ZBC6PosPkkSQ
         3fWOPFm96SjEfX5z84DDedWKEy9vab53DsAFfn6roHaJMPhGT0hyOuM5GPj6kn7jX4Om
         +adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990618; x=1794595418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5QKJmKMjkfOGpFABXHpSYbL0DQQPz9RbFTdkuxGPANc=;
        b=rZ97eurY+C+eaDGXgqElSxWHhjxHbNVZQysm3dqVjLkhVeXky6+uct0lz5EoPvbAKu
         juUpAxvR72uabSLhw8qRrXc238xYfulHxiGpRP8chII0KovRW5MAZO/103rU5ekZDA20
         GKxYOhRzdBvUF0lKmqZwG3C54tedALbu21BG48V7OfbApxreEEQG+F5wonpQu5RqWFyU
         x92e2go4DhkPevNQOvuXWBnj/Gf8a/8KJAvFMMBdB8wP0R6CAn3oIbVbTfw0+4lz+mDq
         MnVITuS25ZShpX+bFg+1gPhmPKxutmqRXgm0Ni9PWnRI1T8KfXLoRGLWjwl24j+H3iIw
         FcnQ==
X-Forwarded-Encrypted: i=1; AL+hErEOKm8eJlwJkQr8+0FdVE/Z4D2v/vzkUzluOToIg+faQwArK7+GzvVvGNJtc5rt+7A9TiU9430=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cMQwJkLbEKbbK4S+NLi7M3NGlEz4OdGgQdBMopVgvnuC0/Dds
	MENgLlokTu1CRHXR6gEA67OEvlztcPhKDI7jwQCbJvUthiGm/ewsq+DC
X-Gm-Gg: AYBFou1eM7vdgAxGKzkTtebyr4l6liZ63smpvtpwmVTI5I55MTdfYDgxP8wC65pvcFN
	hw7BaLQXuNCbtsiZXW3e0Rimqp167qcvctTNqqQ0fVqmGP930tXxMK8X24wZfpb9H4mScXOhnke
	CAcp4lFBV6doYq/KX2PiYotJp2WzrzIGcRv0LsAh2jlW6R7G1XJd589VAKhtTAke3B7OWKahnyE
	kL+s+a9IjsUM1wjTfP3nPD6T5p6VReWNN9qdUZKYvjJ0QxKnaFebaQ9YE7NTreGc7BFSCxrYOE1
	ig35T4Uc1bJhxl5ZM4tYp7i8RP7I8Ymzm+mlP+QZoccq+n9aG0mVntjSXsy9u8xUPDcW4BZsBXD
	14QTSUOlVNyDkMuCrPPZ4GeY8PR3TSvk+fy578gD0HYhRLh/4mEfX+bPVg0he7HqK2vDj4V70Qe
	h6KsPSMNlZGAwgUZubvnC7Z7byv4z04eeL4y2nSclefNnFTdVwU3adVeoTc0L83yQGaDY2wud8P
	+2vv/DzxIfu9q6syBgVVFvYGzaf3I42gS5oneoGiZVlyxFVC/R4qyvp71v0T8HgIpw1n6jXLpkx
	0VZxqX0I3x+rDiKjDJc3Ecg3qfW2
X-Received: by 2002:a05:7300:b196:b0:36a:437a:4c00 with SMTP id 5a478bee46e88-36f7611ec7bmr4202731eec.24.1793990617663;
        Fri, 06 Nov 2026 10:43:37 -0800 (PST)
Received: from JMD ([2405:201:d028:10ff:eceb:5028:6b10:da7c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea414sm8278073eec.16.2026.11.06.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:43:37 -0800 (PST)
From: Atul Akella <atul.akella@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	sibi.sankar@oss.qualcomm.com,
	quic_srichara@quicinc.com
Cc: linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atul Akella <atul.akella@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] remoteproc: qcom: Fix bounds check in qcom_pas_da_to_va()
Date: Sat,  7 Nov 2026 00:13:09 +0530
Message-ID: <20261106184312.100-3-atul.akella@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261106184312.100-1-atul.akella@gmail.com>
References: <20261106184312.100-1-atul.akella@gmail.com>
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

offset is calculated as da - pas->mem_reloc and stored in a
32 bit signed int, while da and pas->mem_reloc are both u64.
For a sufficiently small da, the 64bit difference is truncated
into the 32 bit int, bypassing the offset < 0 underflow check
with a small positive value. Additionally, offset + len >
pas->mem_size can itself overflow when offset and len are both
large, providing a second bypass.

da and len come from firmware's ELF program headers via
rproc_da_to_va(), and the result is used by the ELF loader
to write firmware segments, so a malformed firmware image can
cause writes outside the carveout.

Rewrite the bounds check entirely in u64 arithmetic. Reject
underflow before computing offset (da < pas->mem_reloc).
Replace the addition based overflow check with a
subtraction based one (len > pas->mem_size - offset) so no
intermediate sum can wrap.

Fixes: b9e718e950c3 ("remoteproc: Introduce Qualcomm ADSP PIL")
Cc: stable@vger.kernel.org
Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index f37b77ae187e..8cade27a6495 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -473,10 +473,12 @@ static int qcom_pas_stop(struct rproc *rproc)
 static void *qcom_pas_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 {
 	struct qcom_pas *pas = rproc->priv;
-	int offset;
+	u64 offset;
 
+	if (da < pas->mem_reloc)
+		return NULL;
 	offset = da - pas->mem_reloc;
-	if (offset < 0 || offset + len > pas->mem_size)
+	if (offset > pas->mem_size || len > pas->mem_size - offset)
 		return NULL;
 
 	if (is_iomem)
-- 
2.43.0

