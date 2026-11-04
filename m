Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809303;
	b=dIrlZR89Z/mrZ+6+RDs86Pbe7fr+dLw3K2/xRKIaaW9V0Q3B+W6ACFPSVSKD2kyNbAx/
	 ZKwUKciIPZvfz+cP0++sBqre0aT7mvmnd7xon6NtdRF9+Jc6ZvGStaZYrU2XnrlqApFJQ
	 A5PfznWHZP5HCQUU3lKgyqNQi+lGn93/dpA+vI1k/1JS/eYjFRdaHEihmC4JLitl7k+Y8
	 Q06+aj5pMUntecCX6f1A/3DFtTCFc6XpR31EEGm2n1dAi6IfHkg1BfGtXW8XtphBJDFO6
	 fbCo4My6KGLVAtsDzyw4kSbEpjIl0a1GTCAXj5Fsh6jq9r50BymkDHeikg+vZ3sPWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809303;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
	b=f1ZZR9im4Hwxe5BymjlxGLohPi/Bsgcn/kCCNm9FV4F2/FrA1D7PeIAuu65iAE1y6urM
	 /X0KbuUuO9g2Bmaid+4neza9+udy+nzfAh9qu4kKyJ1S2QvftGX/O1UW1c2ub3T3uCDcw
	 qoj7W7e09IduTr1T54euSleD9DS+z/WqaGR5MM450ZYvLOEtAPm7gWtXyCdXJmnMsfRXy
	 1zHIo9j8uxX0gkGQTFPgmlx40bpF+ue33zk+JprVQxLqKkGzCrZCTKntbi6N1wBWx3mxP
	 VNoq8lt7Ntxh7qHgmIKGTyaUGbNv18sMYVmHqLXZ8JIdfqTQvyQGJpVg9r9BQAI00XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=khynQdHt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hvt07PO7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9A606AAD0
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A9A606AAD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=khynQdHt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hvt07PO7
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FiwVG2250930
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 16:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hiY9I6KwNBi/iiyCvRtimm
	zKZzjCthBLith9u4obNsI=; b=khynQdHtxuXUlWFgn8YrPPweRXKoorWUjVEj9R
	g+naBxh1weCTOQl3ix2Yq8nKsy+wgbqksAcUP8/Ww5M8BBtMUyph/q+2MRqpQLPK
	ynp3STPPgZYOj9gFXPWmFxgr1Mi5mk9sqfDwHomtckz8SG3hFqM7zt1VoYQkOGas
	hz4zEm2yZU7vbHRqvEPPkdXNBq+b/OawJLTQYoPQBDbPF+cBeIhy6hQF2rJJTzoj
	f0rgRN5Gz1kVwy+Pili1w5wR3rDkzvxkGC8PEoeGmlL258P8eKlTqBxyyXCl3WBO
	BeJCZWSqF1nWCHUOlnuz6PVx/Hu+vrDXsJCj7JqcGLvsr3Ug==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn11hr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 16:21:41 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eac072937bso398413e0c.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793809301; x=1794414101; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
        b=hvt07PO7Ejd93tIGj32mZ+IyvYtHEsb+9TwdYfapOoAzLket65sFQof/XIaeCs88qK
         HHfmaT18PvsdEu45RdjuYI6HVRlkWcTZ3OOLpnlA9RnTytGK3Eva+inzNTy/08oevyth
         ayNx5A8xS6Y5rgqkDaNhd5WZwFPw3fgr6Rf3/n3bSlTiDiVjep4QzzD6QQRQ2EDC/jZV
         28R97WTbAHjWYeTrQbjD3Oy7OnoKLrKhOSrmQrLtgwaw4QyDE26uCoePjaG4WuPE6RpZ
         +0VRzj1EsejbZOARZgr8nlIHAwpqpt0tDOq6jyNUz50EXv/C3Uz2HIByuBLyzZy7nueK
         5daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809301; x=1794414101;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
        b=KVe6iwc3EN3r7KFHKfg7gi0wt6FEcHWWQ0X9RsybabkszQtRTNjByWkm0sSwALe3eZ
         Rr2rt/coC9ZPGMKnKhYiSBPa/U9e7Zrdtk/leUbCblN5nX7AajL49jlK0oC8/LdtZRzw
         Z2VtNz23fDf3qx337p2uF9EAVNEG2hac0qX1C3E1HqQ/4N6d0LQVATK9nv2aNYVCpZmE
         MDk/EFuLDz6iCTXT4GjPphmr+feUv4G42CKx1Au+VAFXibr9vviwJL4oSDVfB9tVHssi
         E70ndq6lnIxBh7dUtmw5tJa6urjNwxwH8xbzGECiwtanNiu3EO+WZAacqWYnKLLLnpNr
         kWDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUqRVH/dK8CLvfOnFoAmg0tbcIbOFaisjssiOmR4WEdAdSvYr/VgPo6bR+X2LhUjlGK3prnAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rdHsjqexfOPToCymjEtGy24ke2CQa7FfYn/gF7W08+zJOBvZa
	KsMtGatSlbdpUSmfDTSZUEDxgLGA0H1j+qQ76bQgHc31Swa5aDORxn658iGbB8pwJUL+vmsDk7v
	JzVIuWPAuysMIEIxORKc1Sz7Jl9IXvsk/HCGF2QC1kXaUeMKarMPjQ609jHvbrG53vis=
X-Gm-Gg: AYBFou0ezDZfi6yn0Yvs7YK7+Vfrom08e3CcZpmtjvIEgUvS8Vr03rf5xApNxUM5bv2
	+q5CUNhtDIDyvDoRqniit1KcHGKUkayKOwePMYRrLMwmtGx2zpZvIJzDpOKm1P31fLLSbBt1tka
	FtTAcb2MCOn6Cs79aoHmvSl3xlawDrJnK9uE9Ol832uVVQ0GWaHmMLoC8GLRYaeE/Z3uWKN2RS/
	A4iZNH/bNV423EIi8QI6oZi+Qm6GuaZLWxRe9lM0+D6DB0MCoGgFKiP2QplZGqclda1LrLcCtj0
	Lj8PHI9ZiyQxHhyzjk+JASc9/TSikvzzj8Q4uTn/3I/B+ViikkJ2wvr80Gy6pAa3/4gZt5yk2Ym
	qYUazKv3VxocHiTIMUaeHF7ppBG2SuVspohsM9hbYbUMlOZk1M4drX5XZIMkdvqY=
X-Received: by 2002:a05:6122:1346:b0:5ea:e197:93d9 with SMTP id 71dfb90a1353d-5ec689cf04dmr7881270e0c.19.1793809300361;
        Wed, 04 Nov 2026 08:21:40 -0800 (PST)
X-Received: by 2002:a05:6122:1346:b0:5ea:e197:93d9 with SMTP id 71dfb90a1353d-5ec689cf04dmr7881216e0c.19.1793809299708;
        Wed, 04 Nov 2026 08:21:39 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aaa4b91esm138706365e9.11.2026.11.04.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:21:38 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 17:21:34 +0100
Subject: [PATCH] power: sequencing: pcie-m2: fix use-after-free in
 pwrseq_pcie_m2_vregs_enable()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-pwrseq-pcie-m2-uaf-v1-1-0ae1bbea9533@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI1b62oC/x3MTQqAIBBA4avErBtQi6KuEi3ExppFZko/IN49a
 fkt3ksQKTBFGKsEgW6OfLgCWVdgNu1WQl6KQQnVSSla9E+IdKI3TLgrvLRFLYUSg2lMu/RQQh/
 I8vtPpznnD8lY35tkAAAA
X-Change-ID: 20261104-pwrseq-pcie-m2-uaf-a10209c3c4d7
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4813;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jrKYHbzHuQtQDH1LJjU1wsAH7+nStAGDkNwI3EwYo/4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq61uRKXGWBdRrvCWYVcvySwfBACYO/OgtWSoo1
 sH3o/YY8CaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCautbkQAKCRAFnS7L/zaE
 w/93D/429Cp5VXKSuk7vHjuZgz2bxK6OBXmyg+UxhWJNt3a3nWo8uf6x/Pdky9bSXKvULi3jB+5
 o83Lo4ohWZAoEzbrYlAJgcphlNxtxzWuZMMgP6yVmfK5UDdpxZYHtvvYTmY4ykmv88r/I99dDTN
 CAqKLvRruicC1Wk6pVmdYgMQ3fnHeDGE8bcgWrwT6SROynUzMKqRhLToaq82aIj0IGXUxISBE7d
 73/iOuPMsuEUWUB0ueDIq74J4dHhedi5HLW+WKClWxJBqok9EOUhImsfTxbgNqnSYM+e+sy9A7E
 1chdLNuXKtEfz/lobUGwVlUXaE6/k5tdSfOgeptO2HxaWbktFFoN8ZTkfzJLtwihwFrR1915u+C
 0nQaRYajsErdHDAt4xZhplP6rKrGnisuM4usHmgm5WXdw3EFE0lxIg9OkDhfF2boEh4F+3c3ma1
 tTaSZ8tdvhUT8fDQIl7yJCamrScPkxjNV/vzdOGl+37wOUsLZHMkIe6+eNf/scoMJitD+DBuzcv
 bp8UODhN8pT25NIhIBhyhPl9vK+2JHwsjKJuAcdE7tEg71E5vA4zMWGammiRjVtIdRsn605AWKb
 Fe5LYBkw8SKoIkP5FSMYwinDiYjhVdbdaOhdKKtN6CDnsl13tR3xHIqIO4UwuB0NqOofDWVFy0U
 nZMv1f6vrg+A/bQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfXzL3xD04ekAls
 IQpifK1QeHzt0J/EjXSqknj5A/r6+UPTvQtICAcgrgfqYccWR5HWTS9MTyE1PvSSTcoYvkDi2eS
 N1joGIhfqS3qauk13ZqxRhnfRw18x7go+sxdia3m5/RqAxDWswJ3769TZzTmsYmRR66Q63mlmv5
 2hG7gclzdklTzhLjVCOiuysWcRUr3krcqJ1cNxYq+Dav8zQ2XWZpp5OXuF115iRiogBbalBAleB
 vN6gA1UmY3WEkOl+LpT5bhOwGvoqYr0dUYekJogpxmOLUl+8MvEYCILxn50v3+TR4jjosAJlwnt
 jzt0tjJE+x3sn+h3LoHFwRN5zmbwhL9Bc4GCX1jORiph0zauE/XwSjr4z3YM6vikn7pLWfyn1zo
 hKj8dQQCQnTHCtUSYwK59lJlW4eQpjZjf/73v6UHgmNBm/abU/7w0XDbtBLGmjuU02gTkTt/Ha3
 E/m0MGctnG2ao237efg==
X-Proofpoint-GUID: _4gfdpfUFaHgPQ4Cs-NzxgMrjjv87hsp
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aeb5b95 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mM_0bNS9DA9p5V46oFgA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX8xUrpSx8MvCy
 FgTAmdMnUWpybMsrZbsgGRHnc4ff/v/yG72zFtSHFEx1UaPgUDsEgN0lkuQdbzFEb7fFYsFirfy
 IQCKqVfyjcl88KAz05UrLeWJu/qHwtM=
X-Proofpoint-ORIG-GUID: _4gfdpfUFaHgPQ4Cs-NzxgMrjjv87hsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040065

During device teardown or on the probe error path, a concurrent consumer
access triggers a use-after-free in pwrseq_pcie_m2_vregs_enable() or
pwrseq_pcie_m2_vregs_disable() due to a lifetime inversion between
devm-managed device registration and manual resource cleanup.

The driver exposes the power sequencer using devm_pwrseq_device_register(),
meaning the device remains fully registered and accessible on the
pwrseq_bus until the driver core schedules devm_pwrseq_device_unregister()
to run after pwrseq_pcie_m2_remove() returns. However, the driver performs
manual resource teardown within pwrseq_pcie_m2_remove() and the
pwrseq_pcie_m2_probe() error path, prematurely destroying the backing
regulator array.

This creates a narrow vulnerability window where the globally visible power
sequencer is backed by freed memory. If a concurrent consumer invokes
pwrseq_enable() during this window, execution is routed to the sequencer
callback and dereferences the destroyed ctx->regs array, resulting in a
direct use-after-free and a kernel crash.

Schedule a devres action for freeing the memory used for the regulator
array to ensure it runs *after* the pwrseq provider was unregistered.

Cc: stable@vger.kernel.org
Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth")
Closes: https://sashiko.dev/#/bug/linux-bd17e5b1-a000-4717-b392-0ff0c2a9c376
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c10faba6c978265bcd07a6980d2a52..a794e2ad6a9c8cc71b1ca426df92abdaef8aa85b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -533,6 +533,14 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx)
 	return ret;
 }
 
+static void pwrseq_pcie_m2_free_regulators(void *data)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = data;
+
+	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
+}
+
 static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -561,21 +569,21 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get all regulators\n");
 
+	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_regulators, ctx);
+	if (ret)
+		return ret;
+
 	ctx->num_vregs = ret;
 
 	ctx->w_disable1_gpio = devm_gpiod_get_optional(dev, "w-disable1", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->w_disable1_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
+	if (IS_ERR(ctx->w_disable1_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
 				     "Failed to get the W_DISABLE_1# GPIO\n");
-		goto err_free_regulators;
-	}
 
 	ctx->w_disable2_gpio = devm_gpiod_get_optional(dev, "w-disable2", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->w_disable2_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
+	if (IS_ERR(ctx->w_disable2_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
 				     "Failed to get the W_DISABLE_2# GPIO\n");
-		goto err_free_regulators;
-	}
 
 	config.parent = dev;
 	config.owner = THIS_MODULE;
@@ -584,11 +592,9 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	config.targets = ctx->pdata->targets;
 
 	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
-	if (IS_ERR(ctx->pwrseq)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
 				     "Failed to register the power sequencer\n");
-		goto err_free_regulators;
-	}
 
 	mutex_init(&ctx->list_lock);
 	INIT_LIST_HEAD(&ctx->pci_devices);
@@ -613,9 +619,6 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 err_destroy_mutex:
 	mutex_destroy(&ctx->list_lock);
-err_free_regulators:
-	regulator_bulk_free(ctx->num_vregs, ctx->regs);
-	kfree(ctx->regs);
 
 	return ret;
 }
@@ -627,9 +630,6 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 	mutex_destroy(&ctx->list_lock);
-
-	regulator_bulk_free(ctx->num_vregs, ctx->regs);
-	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261104-pwrseq-pcie-m2-uaf-a10209c3c4d7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

