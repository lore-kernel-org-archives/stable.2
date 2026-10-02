Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E947CA68
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935961; cv=none; b=KIVl7eFnYfDiLPgvoUawr0QPIAdoITvBOlsudQ2n2U0I+JgW0ZBSe7jZBb5KtcFZWp64eZ6uT8KuCYWUsps5Uqyv/rk5iCn2fmLQUJyBhZCQRiRt4oleIuQz6vWGwdrwz4kdArLktGSbUcZK6EtbMhpRmJlQj6THo2EUChlFUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935961; c=relaxed/simple;
	bh=B5fX1NUZL+hVJgVRjIVdI6YCk2Nek1XvofR+LSluCN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksSwWlJ6KzPni1A0PV46zZjaAfVckdsIobBvhMmnZm3sA7b5ECXRObeKRG/s1M+XBLNpYTJi3AINyUl1IHAwqWxUk19vf6mFn+JfAlp3t9dJqY7vZos1N/Ue/z5PfWtrsWXHNN21qsJtDQQlYJ8qAZzzQepmOqr8ihw6uu9QtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cXtRdy2A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gafqksQ/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXtRdy2A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gafqksQ/"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929nYeb3935002
	for <stable@vger.kernel.org>; Fri, 2 Oct 2026 10:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+9Gf7Le8ssJ
	BQEljUcs6+njQi5ShhKdlcuxnV+fQxXA=; b=cXtRdy2AZbO3tKigNUB4AIPYnds
	a/9AYHcBZaxQLfBbHM6lF3N963BJGnkXuXXwdGHTeJc2UebwoPrUgosR3mStHoSb
	0saj52JSyukV/8p8TYkjHLH0SS4rYZ4mEn7aHles5TDpgCG0+jOHS0xJGJbphpTh
	6qssdOmweq6aJJLhxKZIDI5bPYX6kzewHhFDovnY6jqh0rhCpYf3T173nzXDxFIU
	GLzb+sSmlqI8jiVB1rMFl8TzihhFjUJdttsX7B6cimt6KIQdg5JxVz4KOmEB1bct
	tDZLzPi/td9A29JR3V6/Hacc20j1MOUvbwrI2sPB+Bj2Q6AJ3+Py4SyWdBw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1vxeanqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Oct 2026 10:12:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93c5ab5c136so1047318685a.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790935957; x=1791540757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9Gf7Le8ssJBQEljUcs6+njQi5ShhKdlcuxnV+fQxXA=;
        b=gafqksQ/wWXw+IWSMA5jY5PGkMCgXD1xyWea/vcnZyxx4OLGeED7Bpm9ND61oezNKr
         XNREk961tcm43NwEYHKaEZDjgia47Gk9iyyn8gwaeN8k07BN3ZNraw29ANmuOl1TyOto
         5LaRGuQ7pDiPlovOS8+n90OgtyokyhCse9qlyNuxP1R9cKHVw3JmEMiKUMBGHlcD4bN+
         YgCOp5akOsqdJTrwyALXkCEXfOLCu+jpTZkeqzprtHGUqLK257b8hDlFJv8vXQVvzCcG
         24EM2BuhRLW6vEihrDl/wK5a0PEP6wm3jRI4tCb93E2bPOBEo26L/Ze3SMAbBei+zjwW
         Uk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790935957; x=1791540757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+9Gf7Le8ssJBQEljUcs6+njQi5ShhKdlcuxnV+fQxXA=;
        b=QPntUvG0vL/FX4OSZoldS1J787wc3GKYWYakMQ+2ArDSQGQiiwZfi34qw5/bYocy41
         RlAJbHOxiUTHKGYQj1dANnlsvyzJKr67r8VLTzEBEY48rCxQHZLEgZawGlNGLyeQQEKk
         nHOzpJEjHyAkIYIuqKbGqPeR0HGey8wQDyNct5sMfDomhtigpYWJLjH767WGcBQqnk1Y
         1R6s0QT8+jAr8JdpUzUL9DScF1Xlb8/TarQfRY27x1Numb7QrxjCrGRUFhcXXJbiYHUM
         ypeH4I5EyUwt/NOcFvMhg98XT7wzmUoPXS2SBdXetxJ08vZfJEM0bs2xHujwqNuEJ+Mn
         GxSA==
X-Forwarded-Encrypted: i=1; AKwUvByYvXN+Vbn4jKqATBWAI0mXKagMIUrafMxpNUlciX9zQpMN5//2rsw4fC8ANfBItJVoTx0FBDc=@vger.kernel.org
X-Gm-Message-State: AFuF++m/7haKWt4Xori4IxQZuZtXlUSjyI9aj6ZGCl1SdpokDPdJmq5m
	7f5+rjxNQoENndQaf3Xd2olmDEoWEsgWtKbZScTlQBUpZdcWC64oAfi+YmaArspS0fugG6k0QoA
	ToDWLYXXZ5CT9xDE3AmXSUTezGM3atUT452AERK36LYhAiU8o4TFpne1jlbfvkGFsIGA=
X-Gm-Gg: AYBFou2g3sxUxa1Yrh63/EevJPqiKW8SNteRPidXbsACzVMFlftF8jFBLJsFFjji6hG
	7+mY8UhD8OjjDdmPnBOYQRW/hLUzENyY95Lc1j/ZZUaHBBwbLvYYGbS72dGxlvtdu1ZCeQZCFA7
	ljg+wbIp1HQ3KcLck6XffZPtB12i1z1cIuyW2Fh/dXy0Db+3ECEcj0mTHLDiPh/LSq0iNV5XBIT
	MHVGPYdhReY6+iP9V2TIRLJLkYl22Y59FAI3Edohvb1tHK5sykBgVRQqbGw2Oth2okivmhVROKL
	bpW5G6Tgf2fHSb5+aZO76+YOueiqlonziXxilh6xst97qSaS4hiekS/yib8lxdXIwNyRWjTuF/F
	TXNgINdIdQ+KV
X-Received: by 2002:a05:620a:2b8b:b0:93c:a45b:b07e with SMTP id af79cd13be357-93cf174b1afmr329199285a.38.1790935956771;
        Fri, 02 Oct 2026 03:12:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8b:b0:93c:a45b:b07e with SMTP id af79cd13be357-93cf174b1afmr329196185a.38.1790935956167;
        Fri, 02 Oct 2026 03:12:36 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff2280csm39689195e9.4.2026.10.02.03.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:12:35 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, Yifei Gao <gyf161023@gmail.com>,
        stable@vger.kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/2] misc: fastrpc: fix double-free in fastrpc_map_attach() error path
Date: Fri,  2 Oct 2026 11:12:19 +0100
Message-ID: <20261002101220.1084101-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002101220.1084101-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261002101220.1084101-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fdc4WEQF c=1 sm=1 tr=0 ts=6abf8395 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jl5AnXupQmoaVApxsvcA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: TlVr5nJTg90r0lErKo8r8CNJPLVlF95Y
X-Proofpoint-ORIG-GUID: TlVr5nJTg90r0lErKo8r8CNJPLVlF95Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MCBTYWx0ZWRfX7EPBDOcghyPK
 2NrU2uxeXDspVGN+l7JIZ6J249ptfz5c4g7m+NZvUfkkGl88u1PQP3VdFiQQeo0XjRcZH4pBSg1
 vswOvO6+dOsV5R3G8VC39YpgfXViUvCmyzJ5zixNV+Zna6hG5SG9oEz6HbEbxNkQB0yafYV/8cV
 cJX48AV2ieCk2/na85IcxWwDH8cQZj1ZAvsVvEyTGwhBNCzYyBq4A8HZtvsRKubanc8LdF/yT5t
 GPRxvHC4BIUJGT1EYEG4lAXTe36EwKIQPwZg4USBbStERm7+If701mwTRX4XhhWHpzD+wGtL3Oe
 VzZzJORDHcNgrfeEYGFkswpRbjNzTPAOd4yrdU4qBhpd/lBF3uoyqGFy1dyZCaXwRb9HyohtV4u
 du2Ks+wHNK4R9Nsspmf2Ib8G7T8dj9L3Jo0a8qmW+7OB/YGZ0cLdUqyUlQLXfPgSKtTQc6heUbw
 roKWCzrc1bbEOJPgTuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MCBTYWx0ZWRfX7nb+tDeGe+QY
 Nt2EjkGKLwoYNIM0ndwT4S2wLK8y1KvraAkc6oXrJ9GoOdYeBDfscz6kmTgFyBnm03QMRyTWiaI
 TqYbekuSl4UiQepJmt5fCljtHXvJUgM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020040

From: Yifei Gao <gyf161023@gmail.com>

map->table is assigned right after dma_buf_map_attachment_unlocked()
succeeds. The two failure checks that follow, the len > map->size test
and, where subsystem VMIDs are configured, a failed qcom_scm_assign_mem(),
jump to map_err with map->table already set.

map_err manually calls dma_buf_detach() and dma_buf_put() and then falls
through to fastrpc_map_put(). Since that change the error path tail is
fastrpc_map_put() -> fastrpc_free_map(), and fastrpc_free_map() already
unmaps, detaches and puts the dma-buf whenever map->table is set.
The two operations therefore run twice: the second dma_buf_put() drops an
extra reference on map->buf, and dma_buf_unmap_attachment_unlocked()
dereferences the map->attach already freed by the manual dma_buf_detach().
kref_init() sets the refcount to 1 with no intervening get, so the final
fastrpc_map_put() frees the map synchronously and the redundant cleanup is
deterministic.

The len > map->size branch is reachable by an unprivileged process via
FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
requested length, before any DSP invocation.

Route both map->table-is-set failure branches to get_err instead of
map_err, so fastrpc_free_map() is the single owner of the
unmap/detach/put sequence. map_err is retained for the
dma_buf_map_attachment_unlocked() failure, which is reached with
map->table still NULL and an attachment that fastrpc_free_map() will not
clean up, so its dma_buf_detach()/dma_buf_put() must still run manually.

Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 90fd669636ec..4a18081845d9 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -927,7 +927,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
 				len, map->size);
 		err = -EINVAL;
-		goto map_err;
+		goto get_err;
 	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -950,7 +950,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 			dev_err(sess->dev,
 				"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
 				&map->dma_addr, map->len, err);
-			goto map_err;
+			goto get_err;
 		}
 	}
 	spin_lock(&fl->lock);
-- 
2.53.0

