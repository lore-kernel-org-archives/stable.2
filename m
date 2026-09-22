Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6FD54B1DF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081890; cv=none; b=sRaFuWBPzH0dM64cxj6Jg2WYFC9vEijFxdezdLqTB9FZuZrgj8ABZ3+/BQH2bznzTxDK/3+dLuYDdGpXnddGcxYJ+keMy9fxsCcxUvfheK00eH6XEpXjtFrNR2AEGaQFC1l3MDRI5bFBb9rsRgFbrFsIW+96Fb+a+Tuzj0tzGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081890; c=relaxed/simple;
	bh=OONR82+SOL/pvmQQ8fCClk/rQeXHbpvPa9nD7auDntc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRIzg77HVQVKtnCjgcEofW2OMBBR6VFFjFF2QN/M/jZUDAQ5Nn7BHaMrelNstqY9sk1nfE9/XYGgjO5swDXC9kAJDH+/ccf/unjaA9UHNwbXywNHzcWonVin7rPx8gct2HxuBE+YZeahB7H3CHm1aYLncBFLmEwqNQL+ojowZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imjodOCp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F/HpFLa4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imjodOCp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F/HpFLa4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBP6hT3670878
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ExRYRpHD1u5DXOU+rn+njvT7N53U5V0zMU/VcDkIX+Y=; b=imjodOCpU3ZL0tCY
	ABBUU0j7B63ds1f3/1jPcNFiY9j/ILFCT5RdsJAWq9KUPTF8v28rJDd4bzC8ulUK
	vZT1vyGqyE+0ACgjKil5MbXn56JjmZbGE5FtvMOvpyMQyIujvE1+R3ppLP3X+wdM
	dZxYPjcv8JUTY7wzO1RmDgRAf0JLEB6RQvb62BxBL+/fi2Tp0b4SNRbA9ulxsJS3
	UaJlWn9lBzIVcalPC/zlrKnTzLXfny6YhwjY51rq/EJ9UBmLdcT6GbZkksdY6bX4
	VXOy5SdZiT9qKezhlZ6vlC1qkgS7fd+UfpXU58u9+HoehPiO+OYkX7kpo5K5AaVL
	UkG4rw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurnt8dcu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:58:08 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c851df59edso1240058e0c.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790081887; x=1790686687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ExRYRpHD1u5DXOU+rn+njvT7N53U5V0zMU/VcDkIX+Y=;
        b=F/HpFLa4ARiYgGS+tq1qPclSzI6LvKw+PDChNdF8lwnZpxkbNGP5rgYJqawlwBc1mN
         QhY6N4Qc1Fc46Hs0xcKken5Xqq46kyRtsL7epz0HRXW1hSd1H+y8lJhfUFtDsxo5E9K+
         l+0jquMX6Byx/5yztIhvkH7N0Ez+V97WwEJd57gmnu75TYAmnVufGndndGwoyea9j4QK
         BmxsImBSM1dzEUa2MnR8VytO1pQ2BqceubtY3sohJ/aP3u7f2pQsF0efzpLpXGRSwuHu
         FohfEJ5xR1C1xzCLGw2uHv2xb9wQdVv4KMInVCSFuFceN1j9Flkc6qKKMm2OQV6JUJc6
         N/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081887; x=1790686687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ExRYRpHD1u5DXOU+rn+njvT7N53U5V0zMU/VcDkIX+Y=;
        b=lJHrt2OWlogxgtbKS+O18mLJdtEDCY0QnVpnZ5b/sSNerg1a9qZFyTzEgmNm5LzYHC
         YB1Vuv9cHGdW6glKJ9HR1gqT/3wEfBCaPGSQh9EWaH4g/gp6VnoROgKPNzNFgI0RmRJ3
         PMSOiCR/n6iauV/EWQz+ef3QyhTAe4hdKRbTgiLZI4XRhzXYgZwU3q7fJ+DzPwAyJz+V
         gSVxzlNK1hIuBDJdNASVK1wmEok4UHacWfVRndcEjhMko3eHghA46PvPOtO+r6ELz1RE
         8e7fMdpjmQXgTVNFEDU5zWrHdeLGKMCLZsicBkjIeULxn9qY6G70Sx4igGM5f2g8BNFZ
         nMzg==
X-Forwarded-Encrypted: i=1; AKwUvBww0gZLbWXwDBvWIVMJjUNYDh5XpAqms3bZMAmBg3/mXvTVtpEj7OE5KsxwpeNVuPVhbuY4vWk=@vger.kernel.org
X-Gm-Message-State: AFuF++nk4gWAM6UhDgYMy8M9GkWyvdeNJX9TTtLbHbNMC6XlsNN5XW3O
	SWD8DDBSW6wGOCL/v5vvbA0BfF5a1VYO7fFYbmtlH6drIdZK8n5aECCZeu3eTr2FS/H6L4CnECw
	cS82wQbSTY60KqTFDTQ1N9+9AZ+ELB2r5UMtBz8BG9geQwlHgRWTzV3bjc/Q=
X-Gm-Gg: AYBFou3jeo3B/yQriasXmhF6oUiWKqQ67gkwQwBpyjVKdOgi4saIozmArwwfQrHE15O
	GMAlGfTIlD4ScKVJ2YCK21L0PitJryjgKD9VxSQ3y/jOgQ8NuGFZSJeynFiM1UIiDLyh7aIB3oG
	A8fse3ITxwA/fswO8/GFC2Vzjqo2vMowaH4mdneYAfHtyXofSYsPh+H024NVJ7ZkzzxG8w8waNx
	JX/VWf7d0/JBNYZOZR4ws6QHjEY+ewMyKbszJpR84DugGVTLj5aG/O0wRvDPpwtqUjCPtOMqxv0
	rCvV8nJq8HpcAB/1ochsLn4I4e9iHYcoYN/0r7fSHg7bhq9DZgAbe2AjQ86HjnCQrcbqw/bCEfB
	oNWit5k45Dx4HuXO37pyOHMt6++Q=
X-Received: by 2002:a05:6122:e469:b0:5c9:a60d:327c with SMTP id 71dfb90a1353d-5c9b59d03dcmr8273213e0c.16.1790081887361;
        Tue, 22 Sep 2026 05:58:07 -0700 (PDT)
X-Received: by 2002:a05:6122:e469:b0:5c9:a60d:327c with SMTP id 71dfb90a1353d-5c9b59d03dcmr8273176e0c.16.1790081886875;
        Tue, 22 Sep 2026 05:58:06 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa4537b5dsm1097669a12.30.2026.09.22.05.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:58:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 14:57:24 +0200
Subject: [PATCH v9 09/14] crypto: qce - Only register algos if the user
 really wants it
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-qce-fix-self-tests-v9-9-b1aa742e79af@oss.qualcomm.com>
References: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
In-Reply-To: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=OONR82+SOL/pvmQQ8fCClk/rQeXHbpvPa9nD7auDntc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsns+Jn9LOydwcM4CQoOQWJBlbAD5RhyrMWVVT
 Lw9g3EbryqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarJ7PgAKCRAFnS7L/zaE
 w6NDD/9+OnKDBRr8GX6+fdaUuDfZSNtFgYmmVPzjMwA3VfL8hARj08E5EP9nfQPqwxaFforsz9R
 wkn8ot5FQy0BTnhJVdDdXu9Y4btFaS2KFIn4w3Pm7nTN1QzXMuHi7wCJRh3OaXP90eguBImde2P
 HxEMWRJgCKGCY5b3zUPVBNXBXpW+DFoOOF9d4IRQt9/4C2rZF3aX7i4nzuBPPAWRgSznTT0hWhQ
 g++GaMhja6TziHwkTu+JHecWoxnML75DC8vjozQOwXfRgHuiNUaaBbC5zht+iDp53aSD9rpnBDa
 naWjYjp3EVz+gpZL3o95mHT6qWwCvE43c37DCJFL3ZTWZvc+zpJ3MNyQwyaYiS0Qfn3M0rIop8d
 YHhl+18yissDcX0Z/CSoJLF2bVVNLPNW04W0ST9+Cp7+uBr2OwtWd/4F5+fXIOlXhoHqMdcD2OB
 8bQgBT3SUvXvR/bF2IfThMCRE3jCb5N1RKfMvdx8IS+4WEYr920gg4VG54zRBuHaYoSXqmd98HI
 3Lck2utJVZA+xGKmSrLAGVyJnji026sz5Axr2iaiONEdF7gW65EfOUOckxsWAb4HAsRx8Ic+h6E
 UtdYovwgqrnW8+QsH45ueSEudY7gFOzwUGfXTAbHkXwgmYuuQp5LnaGJRAWY/VOBLpB1ENAa4zb
 zhCsOHy8yR5iR6w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: iRYFVc-zrL2ZriW83n4SJLumKLzcqW12
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab27b60 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=s_o0qblw2luIdUq6tZ4A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfXxJaKkTA8dNbQ
 VLrOcB1qPLR9L36WozMC8Tk1aMy+V5xXhlBaOW3pJ27eh0hW0Ylzr2wQ9/lob68kdlIZJZYfE/P
 vgbVD7k3d+Mu6ub7TC8EwgisMLGTCtsUUhM0NtXE0gUW+SbN/vXBP5hRu3Nn7BJSUMG56c5D8L1
 wQw6TzPeDyISLkgwuRamdYyFN/+RVdxJ6JQalyF2SYXfOD1cYbSW143URUOyHHUJb4XVkFRii/L
 upg19fZtmCQ0bm6+3zrfOlXL0aRCOa8Kdf43cu1xjHuWH34GUJ6EN9gaZkLcI8gzBxyvr5jldSs
 Vnk4QKeGoU+baUcfkv7/hdA96/6y3U41CbyPMMkwrWuRK9tpq5jULWWnyFC8xqCb5uvhrDp3EXm
 M0jFrxQ2d+mVBl+VdsMTDB0z1ngT1b7v+n5NjeAh/+QPGRGOxqowIiKKkEub36QS5qWYoK6XMkj
 8B57VYUwscsrX+QmxdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfX7YyanfuHqMh7
 nJ8Bs89bVyxpj2ui7+KVTcgCDwYzvksprCP9q3SW1n8baefVUDzbcoLSmcROpcGALSAP1hnD01x
 vk+WDHWdYrR5qm1fAnPAnRoh2Wdg0HM=
X-Proofpoint-GUID: iRYFVc-zrL2ZriW83n4SJLumKLzcqW12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220187

This driver's crypto algorithms still have a few issues that need
addressing which don't currently trigger any self-test failures. For
that reason: don't register the algorithms unless the user really wants
it.

Add a module parameter to the QCE driver that by default causes the
driver to *not* register the crypto algorithms. It will only be one if
the user explicitly passes the do_register_algos argument as true.

The power-management part of the driver is kept as is to allow scaling
down of interconnects gating of clocks by runtime PM.

Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index bf3c1bc3ba7bde5e5d08e06071c67ba77af95695..5b1bf7a50f88c890da1f0820fb9e070b3d3f4708 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -10,6 +10,7 @@
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -22,6 +23,9 @@
 #include "sha.h"
 #include "aead.h"
 
+static bool do_register_algos;
+module_param(do_register_algos, bool, 0444);
+
 #define QCE_QUEUE_LENGTH	1
 
 #define QCE_DEFAULT_MEM_BANDWIDTH	393600
@@ -259,9 +263,11 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	ret = devm_qce_register_algs(qce);
-	if (ret)
-		return ret;
+	if (do_register_algos) {
+		ret = devm_qce_register_algs(qce);
+		if (ret)
+			return ret;
+	}
 
 	/* Configure autosuspend after successful init */
 	pm_runtime_set_autosuspend_delay(dev, 100);

-- 
2.47.3

