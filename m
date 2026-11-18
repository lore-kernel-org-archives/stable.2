Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015824;
	b=W7Oh6usAZoRRLHwPl4YcZTya1qosPdcict4O5xc0oJVYfxcLV9jvd1GV+FmzAINpflvb
	 5I+P6a0mhk5VPYXs/rH11PP5oTn7sXGE7hHbq3iyPwXBairDNhF1ijkvKBpqbyekCNX/x
	 m5xoGj151oFCOJZQlgoV9cdzNVrhJTynS3X4rEV3wOLm6NjzyIx+c0oCIxYEwdcd3ORjf
	 +kRjAoNmuDQCq4JU3FnbT67ETF5We0TVLkjuukHrkHp2VeF15l10Pd6n2m8k4mlBKRxhM
	 HblYNGBWpsH7C+ycjh5HrnhZ8Pf2/iWRhdnsUdMum6PlSReyZVLP5pDzOQCdIpGi70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q1uTWmN4NrrhHRY9maAq9K2SZl1nt7OOy9DAyvWQOgE=;
	b=hRJ02Rs7qOzUUQb/tJ2Cw6pxJVz8dQ082wQA8PEzj4Ap3hdnONR0qHCWEv4xCoqn/yKF
	 41wyBLmLKcu5ElbDNrq0YClv/PE5P7tfBk2aX9TMs5iJcP7jcsWkUtwaI36V0pDarH5eY
	 fpy65NQGYGnSBzkGgwu8u5ycAsmUPeGe1Ex/xzedg4qv2EzR/U1ZR8Cxsws7SK6aVytLK
	 nktdpvm4q+jB/lDmE287xVJSa7YCFh9dPRf3Bw3R3I2k2V52+/qclX/q3tvKM90ryK5ID
	 XxhUCrs4bulmb2Gof1zSNro1E/PumJtWxadSbyML125WQuXPI0CYyJRgxG8mj8H3X1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6uWcVQr;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562960A2601
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2562960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6uWcVQr
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33fb4680717so2701517eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795015823; x=1795620623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q1uTWmN4NrrhHRY9maAq9K2SZl1nt7OOy9DAyvWQOgE=;
        b=F6uWcVQrM1ix/hWYJWn/zSpbvp5y5DuKWIloSvzXxQhnMk150O6W73HYmuVCUQMaCF
         WpakeeKGe2hWKvi0M0EIxrt0iPcr/KDtkrLnk/oQNvbMijYuSX3a+PiaFRxi8BcHygMo
         P83KCXfV8Vbq2w6QeoMaZtfGVOeVlm0flu8XJnT+asq92yOZbrhHnEpDqGiURmmSKMn4
         DgLhTCI6jsLEguwDX3vldS6a6jdpXi2BnW7kLbmcaTKqcROI4DrXxRYYgQDep2Y8H40q
         gQUsEhYWGp0wwz1IeBerE1ysO18L5UvbVQs218x9fGy2dLmD3DcWrc6LkWiTvS9OJQyW
         vyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015823; x=1795620623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q1uTWmN4NrrhHRY9maAq9K2SZl1nt7OOy9DAyvWQOgE=;
        b=cwtGP+bBbJ0cd4OKrNIgrKsymcmCv+ENHxW7p0gMVHMYjymQL/AaIts8aX+Pb37q0u
         zJW6rBOk+IW6r2+RsArU0u5rYnjH7s3q2pvCz3v4ZhZIqOvoq+b8/WiYkiK+tQJNo9VD
         Hmhh+jzjSGUoI287SaxksVKKcU2Yl/A42b1PFd6foZ23QQeH7z89KTChQ59S6tlMKBtX
         zu3WJ3xCIWUe/OIQ2859T5qBzVnsVpLBvOV8PUVeuAux1OlGwBYOyP56Hp9FGPIwikHr
         LSLl6keBy7BgFC1IJsXMqn1y4oFR526DaLWAkbChKXYxuvQkV8Rx1CzFSrgnkNwmwkII
         uMkQ==
X-Forwarded-Encrypted: i=1; AL+hErFTFN8/yBRQeaSg8Tz4DRAOA+wcR9xF0Xt9HFxmSCZXmggAhQYsIKDLGHAyW7qX1Hk74okIK/o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NANK1PjThOcVRPlH1UcBkPyJZ4Ig81VvZfcm+vH7Lv1xawSSP
	Bv9EJ/00wyVk4Twh5AF/rVloeSTZ05Tm+qmS0X1niu3cECLjDkLL5kc0
X-Gm-Gg: AZFdTZcEuiww3N+00MPN5Uf6mM1naDEQyEEoHCENxlvZ2c44tC4SZBRgiUnM5ECQWsX
	eqwR8++6QUO6o3ot7vjJQqGN+qcrojFier7gf88vm6skE0Q6Oi9RRcPbSA1H5ctyvXHxxSXCJD2
	cuesHuP3UF+iyLPdXRTOu7R+2wRP9uRvTeFNOhXV5rRPY6Dkdx1k3IdmZ1F2QYdejriefpakP43
	CkXlhTfP9itrKW1+e0sgsvX7b8yYR/ncImcnOlF5cFGnMli4LzCy2r19XjBnpIvmrExw/WIQmEw
	S5a00l7M//xRvbKTCUkur+17ibI+rWcEjgngI2Rp8idBa56VjPtiJsGYKgyDA4cmDnEMY+T4PDB
	C4MJ3AwRM4wLfAa3k6SrEZzdGE7To15KliY7Lnlwf9u82NryRYtZPuXRtNvpyLJ+Uv0qF29Mfza
	P5aEGr92Qo0+dKT89hAoVP4+oJyEyQbCyxJ/Udaa5gM49CqPZytUIkIj+9HH/0cmH5kKTFv1V4A
	Sbo7/KCqlvflSCRwWorsguMFBsE+jdK/glwhXKdN/b+P8PyJIFBbUbCtwdeF6wiuj6zAxI7tFjh
	kGMiBu5Net7g2V+iq1iS0UJk6oXtGXc/PV5BoL/srtZsTemFZp73UMDk8mxvlBSJVoVu+i4+0Oh
	bqfYJ9g==
X-Received: by 2002:a05:7300:e009:b0:370:a11f:dcb7 with SMTP id 5a478bee46e88-3828161f1d8mr2879861eec.41.1795015822594;
        Wed, 18 Nov 2026 07:30:22 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:2c16:ada8:2d24:d03])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a630517asm8922616eec.8.2026.11.18.07.30.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 07:30:22 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Wen Gong <quic_wgong@quicinc.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Anilkumar Kolli <quic_akolli@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH ath-current 1/3] wifi: ath11k: don't walk an unallocated regulatory info store
Date: Wed, 18 Nov 2026 23:29:40 +0800
Message-ID: <20261118152942.62838-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118152942.62838-1-enderaoelyther@gmail.com>
References: <20261118152942.62838-1-enderaoelyther@gmail.com>
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

ath11k_reg_free() resets the regulatory information of every radio in
ab->reg_info_store before it frees the store, without checking that the
store exists. SERVICE_READY_EXT counts the radios before it allocates
the store, and since commit 64828f091c7d ("wifi: ath11k: fix
reg_info_store leak in ath11k_service_ready_ext_event()") its error path
can also free the store after a firmware restart, so ab->num_radios can
be set while the store is NULL. A later ath11k_reg_free() then resets
the radios through the NULL store and faults on the second radio.

Reset the radios only when the store exists.

AI assistance was used.

Fixes: 7004bdceef60 ("wifi: ath11k: store cur_regulatory_info for each radio")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Found by code review. Tested in QEMU with KASAN, using a test module
and a test-only allocation failure in the SERVICE_READY_EXT handler that
leave a two-radio synthetic device without a store, and then calls
ath11k_reg_free(): without this change the call faults in
ath11k_reg_free(); with the series applied it completes.

No new W=1, sparse or smatch warnings.

 drivers/net/wireless/ath/ath11k/reg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 1030e119fd90..13e2ac96a12c 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -1049,8 +1049,10 @@ void ath11k_reg_free(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < ab->num_radios; i++)
-		ath11k_reg_reset_info(&ab->reg_info_store[i]);
+	if (ab->reg_info_store) {
+		for (i = 0; i < ab->num_radios; i++)
+			ath11k_reg_reset_info(&ab->reg_info_store[i]);
+	}
 
 	kfree(ab->reg_info_store);
 	ab->reg_info_store = NULL;
-- 
2.56.1

