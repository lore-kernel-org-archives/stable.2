Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3255D867
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957450; cv=none; b=CXvlOJ1yIpg3tNqwKoo/UG+LlnJlUca1wo8wQfm3h6XtJ/SycBX0Birnb7C7P9tLrX6Is5qDONzYPkgcxbbZfWSyYBo5p4Sr1in2ymryNANbj10x+PP64c1/9kV0txZjT9Wbh/wJo8454AEH9U9pCq0mzBnwhCnb1w/KTtjORio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957450; c=relaxed/simple;
	bh=6repGLUNrgVfsf2TAEMxYryccpKQnbHINlMORO8gKZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIQJIP6GMnbZIqpxo9aA9oJxmBXrCNV7mMLB8ugqZyscXf8eeGXuey6G2iAobtJzE5E8DpcyxNCnMBeU8Mp2mzfX61b4MKjrvg4weOrlYImxv7z8EaVQoibuMS/3cz2Jkfo/loMhScpQyC26VAriUjUG79+57EB/zfzwaHRMY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CabGPaHG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fX/Ze5/H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CabGPaHG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fX/Ze5/H"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BoXeA2698591
	for <stable@vger.kernel.org>; Wed, 9 Sep 2026 12:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	shxfk64WT7DU4wrhJlkTYBHV8dk9ViK4RzFH9GS22IE=; b=CabGPaHGTUDCL3Xz
	cwOBMA8vDb4DOl5l3sjvS4V0uB/57lmLjqf/pi+cD1v2likF2Uk+ECHFHIYo/UdO
	vw1x9gxj3cb4XwnT6XkUPjqQ7IHtC+JhY2qMuVdvFOffwgGvoj4+5vrVPY9NbwKq
	GQfOpcIiSm5fA1KBkiAGGtQcFy3q9iiky9n3DWJWp3ARm89/VpNoxRsR8qzqsfES
	H9urF9qWwjFXpdaXfgAYGKD32HPk+jpAz/Ond8Q6FjNUDvBOsNOmD94sj1Tqv6fM
	sOX8IMzWZzKxXx10er9+dySjWhQz5WYEGnnkN2GQnJx7qmy4HZKUG3LoDKAsGY+q
	+4M3dw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk6xh059h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Sep 2026 12:37:28 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-785b66a7017so1369629137.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957447; x=1789562247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shxfk64WT7DU4wrhJlkTYBHV8dk9ViK4RzFH9GS22IE=;
        b=fX/Ze5/HJsWKSmbLvpNeCPuLMyEDzFqeldYi2PrRALter0Q0tuRXdO57IFp6E1PMmQ
         o6aT248iAbVnSLYOzoGPjchZxII9WoH04HhlFBRJ0JECrxtVBvYPIL1R93F6Ns9PsX/a
         7sM1ttlDh3+weC8UxzSY8DiywLz+7gp7RFzJqHA4lyRy0LusA33HKjfAH59Z4PUopd5P
         slsb/h+ZSxY550hgZZaEfE2r1o/YO3Wwd5y+u+g3Ys2/bGDf3nCmetPIJMrjSbVOa6Rr
         SuyubYCQ0hZtJxnwbzZWlIkvNK8u5CirtKf8JVnKEHRMLAeZbSyx6pZVCu9nQ3aFR8eG
         c0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957447; x=1789562247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shxfk64WT7DU4wrhJlkTYBHV8dk9ViK4RzFH9GS22IE=;
        b=V6lSzj2w37lEQRRfrie9/zSN+Fc1qNUmJltxiau+rirGgkD0+3BcICtZfcOSaNln7N
         bZgDHn3zSSpSa0EfsGG0O6yw37VXp+EtKGgW2syVfDNthSbJUm0byLGJ2xnFwsRro3Ag
         HxHpNY5VPT8fSUG5ltrot+YwxPe2GWSWympZdvF8C6ziez3cqHESkdoA+f9R7/6mFDkY
         ywvPoKcFl7ojwbIiyQqxDlTGjX++0G5J+CDhY0ccZKxRK0EMDVZGyn6Skee/arRDm2E7
         7DDCpd5q599sy3d9ikz3pRj3ipapyO9awxj2IXeSIq2e27FKdfUOkcEapu7bjM6ige1U
         qutg==
X-Forwarded-Encrypted: i=1; AKwUvBwTnI08rCCf33plCeARvHmC4WcVBiM97UylUUOIxVdREjZ3IFW3QANlguZ3/UbSt3WfFvb+FCc=@vger.kernel.org
X-Gm-Message-State: AFuF++kMDC7bWdZY1rHeCuAlqh2hQ/V7Cc04om1qN8vAsdn/zLaGSCxh
	qKLYgTPTNrDD35ctL1XLZmYZkno2WjiQrCvaxi5qdQ8uRrc8ef6RYNfWDTxOZZv1g+L6iegVbpA
	skBtbZSI0gP/JNU1O8THA1O5Xi770KckaSsI1+dif5THMcvLqhbcRV/gWPS4=
X-Gm-Gg: AYBFou3PmCTgaKy5Ph5f+RiqAoGkhKQxrDWYdff3qIh47VCzx3tnl5cPaJSecGsonvY
	8G5poWoSYPyRTqEla+b/C9alaXTjyyY7BN1DUzeYT5681JJ4ixyZ1l/pD7sQ0o/dHiSye5GPIlY
	zz+8CuLbba3wKHs6co49+Lf5yLYjoeNVskBbfoJ56ydhM39ZEFdO+vMq/uRaHeNMOv8Ps4VkLNJ
	Il4j/Bkill6C1oJ/Mk7AOsH3yCKslpUMAKuaRPxGWNCDqjLCX9h5krqmgE/jxIvyDIKaBWz+Uqq
	xNGCTQXxtQPf6cury5NxLruO+omBJ0ypNWqyUr0UlH6myOhd8cB5lfpQV12FQpuxqI6p//fFMgD
	Kq1lCfb2WxyDW3ftEhwmo6jf5r9Ra
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id ada2fe7eead31-78a4a7186d7mr13704035137.7.1788957447600;
        Wed, 09 Sep 2026 05:37:27 -0700 (PDT)
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id ada2fe7eead31-78a4a7186d7mr13704012137.7.1788957447169;
        Wed, 09 Sep 2026 05:37:27 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:de8b:7fd5:2738:cc2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm36317328f8f.20.2026.09.09.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:37:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 14:37:08 +0200
Subject: [PATCH v2 2/4] power: sequencing: fix NULL-pointer dereference in
 pwrseq_unit_new()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pwrseq-kunit-v2-2-ef496afc89d2@oss.qualcomm.com>
References: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
In-Reply-To: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6repGLUNrgVfsf2TAEMxYryccpKQnbHINlMORO8gKZU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoVL98WcjgMDeiyBAjzKFCykewD3nYcFjSqF6I
 jnCeCBj9DGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqFS/QAKCRAFnS7L/zaE
 wyxXD/9ml1oNhCbvMnk3AskOyswv+qxkFD8qDg5FTzVRFqdeB1SnzL5dw9ffTRZJESigiwHErkV
 66RtiO1BAPE/WKrnClpD02RbO/y2AncvPDWUqGv90vNhGf9aAnRhAFQ/yoqYZa3INaT7OCL6nHV
 RRCXjUmbHMW1Qk588T+vonQf7Yl3lrsjKp2eB8S5RYOKi4Z0j/KFKEQOk4NYlAldajdaxkqOPBz
 oDtPIaEK3yMFGcxZ/tgBqSlo2vxnSzWHITFjh3EWMf61Tlk4F8c1ycNQNn646PTjYwqPbKuKZSE
 rLh/nIb8l8iUg9zZ7UKLiSqCSCMnJ6rDmCS45TdRtPdOgmm5CeD2EZYOTndRcr00vJnbeCw2jPo
 3i+vTOeyR3Q4xXqfOG7MEeVOZ153dc3nDhYjP4pQ7FFBSmPQMKqvrtKAMoQ0FlfhrQk6MKEQDyB
 sCq4nvTI9elQHG6hGzOAkoTjM9Ag8POO+1U1JWuC0+M4kk/f3N5uZFczTbPbw9VBropVLb1CN5k
 x13LPVrHZjomAxlXGVAwwyqJ3bAl2s3oObKC9UB3RYxEsuMn4RRTmtFDdcArVqAscvU4nvDbH+U
 bGwEY0fwJummPA4UZPjqLRY1kWpV+tYoNfN0YkbMPBW9lRgIGu63xHzXLwHWM/xN9MgskiFDLzT
 GjIuBzXESvbcneQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX3BYg3ZMYJAJJ
 dWMllFW87EX3c6HJllmtOe+TUjYwX2rug0X1pSB406ujQApO5OVPxktljrCOqos9khhK9KcCY0N
 hLyXjqIsuyGhWugSOn2//wd5VbXS2HUDn+tr6iU2mzgdEn8quMX1RDeg9LJRyEpIHvcAW5Z2vDa
 e/g3z6yw3UOa9++qFOQbsNxGawRETxW2euqQsVSO0ptxzqrBtkFJh48Y/sVXgUv7wtz9kbzBasV
 axq4cVSPDtCGSf4LaodBAGIitI7YMMwtlxns55Pe7Paur7r1s4zvoQNxSZ1LShetnd+vDY8jIUC
 3RfSZPCIQKWKZBxAL5wyQ59Hl/dNnG3N6HkzL3w2x5uxQ87Tiqz8+X1lULNoGXiawTKA4YqpdWx
 ou5yneK5gRg1ZRLCSvAYw16mfkPpWLOqBULqjAILkeKgNdHQAaFjyFJQ2QZyyRAYNLTPwzd6SKl
 u6oHsArEpaxUnHvvHGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX1uSJAb9ATWbC
 +vlubHCJJy20ZaSFYTQbTjOkmECYDuAxdcUi1RdL3hQ2dnEl8be70V/dKPr4lzlgkapO4xf2645
 wJGxyq1G0QAa0mW9gjseHqLhJOh/wdI=
X-Proofpoint-GUID: IXah3px1wjSrq0edMNJvzkKl2Y1Y19-3
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6aa15308 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LS90zmZLc4-xERvDOr8A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: IXah3px1wjSrq0edMNJvzkKl2Y1Y19-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090141

If memory allocation fails in pwrseq_unit_setup_deps(), pwrseq_unit_put()
is called to release the partially initialized unit. However, we've
never initialized unit->list and pwrseq_unit_release() will
unconditionally call list_del() on it. Initialize unit->list right after
allocating the unit struct.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260903-pwrseq-kunit-v1-0-1f893d2cabc2%40oss.qualcomm.com?part=1
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index a26615b727f6fe8e7cdc3ab1d3f362ba2f1c5684..a092031943397241b2a9970de5793a0bbc8d7ecf 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -101,6 +101,7 @@ static struct pwrseq_unit *pwrseq_unit_new(const struct pwrseq_unit_data *data)
 	}
 
 	kref_init(&unit->ref);
+	INIT_LIST_HEAD(&unit->list);
 	INIT_LIST_HEAD(&unit->deps);
 	unit->enable = data->enable;
 	unit->disable = data->disable;

-- 
2.47.3

