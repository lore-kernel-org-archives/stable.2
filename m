Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510DA37C936
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694443; cv=none; b=Wz+8d+yiEIOX1et7S8JDR4Uy4mMxp/DEbXRGaPBBAaKquBAW7KqZuUffYyQd2g2fCj2OL2GgU2KqUJDz/eLGIy95NEaThALpL5D9GDdG3c7lINjL2yVB+D31jx2Yf1qYRWBoz2VL6YP6gVW7axuD6Kxdwrd3W6a+taefKvpnEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694443; c=relaxed/simple;
	bh=aFCdiu3lE6iqtTzW/LxyPmgEKxVN6MpjkNd0DWaLNzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LY/lybSrtsALTtAgV9YqeookkR4/+knW3W+UxGsaP8738tsnViYByrFW7r9a23M1pDZ7kpxlx2cRkbOw9j8sjtu3tDp3sBskKU/vhh5wW3EBTGLiI8pIlhnOnKI6kY4bQ723ug2w0gNpy+7qfVDjK5YtQCfjZtKXycueNr+24KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xqm1LdYI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iACnzUjA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xqm1LdYI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iACnzUjA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HAi4AH2573969
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Bg98soEYGpUVZzXvY9pSA3
	tZiVKsw4OWtI68S3Vo+F0=; b=Xqm1LdYIxD1WjlE53utRXeLaJL1a2U/Q5EHI3R
	SgZxfprwu7Pn9ZSfO32AyRUNvCGLA6RqmaMt1VOLnXgzxCgvazpDS9m8jHkLH0Yf
	ja7GYOg10dfbtcAiEGxnugUZYEaxu0jf79vhI3OP6Uf1BgRtusQEK9zMK+Rafddd
	7CmpxoVo5gFtJGsJhERR9ItG3LuVMU7MvFhswLcU5uBzNu2+izNfWIwayUDswk7t
	4JzjBoZmBfjNxtVvUA65GLEcYH6ww0CSH0P1kMRvGyCoj7d2qSzxmD+1S4StkCwP
	276TqmmW+VqFHs6snwhWLoCsQniyEvejmiZeHxfYdNNvsk7Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2auq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:07:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37c648d3ab9so1157646a91.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781694440; x=1782299240; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg98soEYGpUVZzXvY9pSA3tZiVKsw4OWtI68S3Vo+F0=;
        b=iACnzUjAJBqi+MIXProiSGR91Yat4nZ9EiKqFb3CCdcyXOcDq665GQusPyKJyKPufi
         mp1Tjo+HiVtFu7IEjjR8anm11p0hAKBH9jtAWLA33kZ/z+9gT3Oiaf3CKROcgG8v1PcQ
         MPlu+U5pUqzP+BCcLDXSV+IJUW29WPojfRIASbT3AU8jdbKEu3XSq4wGkoFVyGWJIlmU
         ITnVj0JcLrFdXCBimWp+QNBYX/9eFfSX289/Gt6YfWGeLrhRn0RxI8mHycDbPAGwS9V9
         hKvY5y6RLLEZL5aU/NPK/pbXAXG7TN9shgg0TEJYsMyTs/kGJXMHuwLoMRPMGeZy4htP
         hCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781694440; x=1782299240;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg98soEYGpUVZzXvY9pSA3tZiVKsw4OWtI68S3Vo+F0=;
        b=WeaQ9hyObyf/kZ3CSWCGI6fVcUhSVyfeKXrRuFw8/S1Vaf6P9FGKlQKrXci2VIX/sY
         adK18nifvgXfEnq8g76HQ0Oez/s4BevdYZpxNlxQBdjm5G+CDknRyz8I7lNxiZv3B/4s
         +fKMRC6s+rjjBDTsarDg5Nu6gDXIxbRAS2HAzYz8P4uufejogyn8XmxrevkI0Z4iPlsP
         W/C7J7DU4Naz5G5JCNS4Q+xI4a4sQe3uTPTmvRpWemVVca3g2PDQuGloHJ6Itojco7bH
         8DIVPYO+agaZyWNnk3BHVC9ZEXkGtcrfoxbPy6pG1HCJyMjFenwcIbAqYz8l6302qojn
         t9jw==
X-Forwarded-Encrypted: i=1; AFNElJ8uB0FOzRG34stwA93AMcISPVTgxpG64TT9tce8XluWy7Mz0rgMmpEt3EKod5ZJcJm/lSGvYdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQqW8lTmp7xkw+pLDVRrgVNMcvcU3GQ96DNDy45DyoAaMPQeC
	yKePUy/r2v3XF7kTMHSq1CtzIssllwtdjBMr2eE1V9IVW8ARAIpXfMyl/9oc9zLRJ6VfyGuY7jH
	he5UtH0HV1DybNE1/b9StgSe2OgggPHtUOyHQsfBIH9McI9h0PmtBzvorIItzwzSX4Lc=
X-Gm-Gg: AfdE7cn5KjUxHiAkzPY2C2sWyYn6CeHeSFY7Pf+mglMvUbnq8pbs1AADZz1L6JO01kQ
	FsXmXBm8UtRckjNNCR9VmNsX0tV4tWRtJZW18OzZWQc8vD8auZ7Ui946oa5XbF3GzaJqODCl3jW
	fiSIX+6Zwg29+P+tSowx0Br27dg4T41oHEswyjB3vIiP7p9gkCoi00rbR44Z7C1I5WVUlBGXAfz
	qWozF5CRK/6QDVAzVaqKYFh4GpwU/bmRdX7fFwWD9Sz8nuIpUSmsSOADFOv+vB1QPI8XKTjTA9f
	ARXHtV3LCN2yYeTSrvIKAOc8hpbTCFlUllmXvabldiTGNs27uB1SA6+iCLzD+XBirwnveXg4oHA
	5UkR/P7UN+4x4tUul+JqhhZ9bWQ3bXMvd9HsIgVJeVwaSz3e5aAJK0Pyeh30gAJxgWaYDaZ7XPV
	6Dce84ig==
X-Received: by 2002:a17:90b:2e0b:b0:369:971:4888 with SMTP id 98e67ed59e1d1-37c9366b933mr3395040a91.15.1781694440259;
        Wed, 17 Jun 2026 04:07:20 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0b:b0:369:971:4888 with SMTP id 98e67ed59e1d1-37c9366b933mr3395013a91.15.1781694439776;
        Wed, 17 Jun 2026 04:07:19 -0700 (PDT)
Received: from CHUNKAID2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb5bsm5577639a91.12.2026.06.17.04.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:07:19 -0700 (PDT)
From: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Subject: [PATCH v2 0/2] rpmsg: glink: smem: robustness and debuggability
 fixes
Date: Wed, 17 Jun 2026 19:07:12 +0800
Message-Id: <20260617-rpmsg-improvements-v2-0-477d4eb569dc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOB/MmoC/22Nyw6CMBREf4V0bUkfpkZX/odhgeUWrrEUeqHRE
 P7dgnHnZpKTzMxZGEFEIHYpFhYhIWHoM6hDwWxX9y1wbDIzJZQRRkgeB08tRz/EkMBDPxE3R10
 bkFo7Y1geDhEcvvbTW/Vlmu8PsNP2tDU6pCnE925Ncuv9BPqfIEkueGOdVQoac3anayAqx7l+2
 uB9mYNV67p+AEy/8JfNAAAA
X-Change-ID: 20260601-rpmsg-improvements-643a6e133f66
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.lew@oss.qualcomm.com,
        tony.truong@oss.qualcomm.com,
        Chunkai Deng <chunkai.deng@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781694436; l=1910;
 i=chunkai.deng@oss.qualcomm.com; s=20260512; h=from:subject:message-id;
 bh=aFCdiu3lE6iqtTzW/LxyPmgEKxVN6MpjkNd0DWaLNzQ=;
 b=mSx7kXRauC9GCN+NXuDAlCe0wsy8OHvjSkdn3zXVhplASnSJiMHoq+9oFdnph7/8mNvrNsqku
 huW1inFogmvAsb7XFSp1LeGA0fj3aeuvOKNg7avayiMnez33x6OmUjY
X-Developer-Key: i=chunkai.deng@oss.qualcomm.com; a=ed25519;
 pk=NfifEElkZxgJ0ghUBxNu1RTaEqtoCGYDb0k5UzIRXOY=
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a327fe9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=4AVfmZjCmJ7tvFRkCBYA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX63ZgBOQTtq70
 krUYMXtYG6Ia0WDkbtDLidJ3aKSf90MTmW6n4iRLg0puqC3AP3zrFgyIMorfNL3AXVrhnUfr9OQ
 Jhuh2mmUHuAuR+wAzgOMDTWtvXTsfYo=
X-Proofpoint-GUID: Pxe-fTCem5KNLD8NYMPQoyVWHAy4uzRT
X-Proofpoint-ORIG-GUID: Pxe-fTCem5KNLD8NYMPQoyVWHAy4uzRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX7BncPfrxayhx
 DiUD6E6X3C3XIG6C4Bq3oDdGOeyhmSdOWtBSjGlpgoM+mSSck4qBAnBpNlRW5gXiZ4jR+BDY1W4
 k4+SHgP+q8YOszTfFbhBdZxe3ThrBjO05K3vz27CQy55XgQwhcN0r+ElkgJ11bh8K0m+AQE70OJ
 352aLnO5O/X/6jSbyGjbBiDLhOyJejxBE17VCoUkqnIFs5RkXL5BCr3x4k2GzPkruQQzws7Rr1v
 kLdZLixyvznvceTFF41p0AnpSv+XxMrLhB4EumQMBQtZp3CPINKhv9M6w9ZsrRIK6An/65Q+YMt
 3RVyjNEPooF6CNr/B0lCi5Pp9xBQZcssMCy8R/n806Rgp3x6dhrVXxUDb7k2l1cAlYgUG7kJMLc
 S1mq/IwaIWMZ9Wevtxv9PMzIE5SwOXD+h9wvf1VaL7QM01VmvTyeEwwslminWbgnlwzYmZ2rQS/
 +5bJSrdelOHO+LQ+pLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170104

This series makes two small improvements to the SMEM GLINK transport:

1. Add WARN_ON_ONCE checks in the FIFO read/write helpers to catch
   and report broken index invariants early, rather than proceeding
   with an out-of-bounds offset into the FIFO.

2. Pass dev_name(&smem->dev) as the IRQ name instead of the static
   string "glink-smem".  On platforms with multiple remoteprocs each
   SMEM GLINK instance registers its own IRQ, and the unique device
   name makes each entry in /proc/interrupts identifiable without
   adding a new struct field.

Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
---
Changes in v2:
- Drop the modulo patch ("rpmsg: glink: smem: Use modulo for FIFO
  tail wrap-around in rx_advance"); per review, it papers over an
  unreachable scenario without restoring a valid protocol state.
  Proper RX-side validation of chunk_size against rx_pipe->length
  will be sent as a separate patch.
- "rpmsg: glink: smem: Add WARN_ON_ONCE for FIFO index invariants":
  - Drop the trailing comma after "skipped" in the commit message
    body (per review).
  - Add Fixes: caf989c350e8 ("rpmsg: glink: Introduce glink smem
    based transport") and Cc: stable@vger.kernel.org (per review).
- Carry Dmitry's Reviewed-by on "rpmsg: glink: smem: Use device
  name as IRQ name" (no code changes since v1).
- Link to v1: https://patch.msgid.link/20260603-rpmsg-improvements-v1-0-dcfc22ed69f7@oss.qualcomm.com

---
Chunkai Deng (2):
      rpmsg: glink: smem: Use device name as IRQ name
      rpmsg: glink: smem: Add WARN_ON_ONCE for FIFO index invariants

 drivers/rpmsg/qcom_glink_smem.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260601-rpmsg-improvements-643a6e133f66

Best regards,
--  
Chunkai Deng <chunkai.deng@oss.qualcomm.com>

