Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0C39022A
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115561; cv=none; b=npyfv/UwjPPmqfy9hCWrJXE53E1wU0oLQHk0yDi+7Ax3ts+TxQBr8EyAp6CPhwLzzH07TKRVTcbkZHcGlbDVI0s9Y5zDLNF5O4PaTL+43l5NAPZsGwsysmwPkR0GFv5xs2zTjrgOewbDWl+wpfj8EuMV9UHEz+LSo0NwS9S6f2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115561; c=relaxed/simple;
	bh=3DJMMCrgCSKDouR5F/hK4CUhTjXeO5GrMSVZMpdPbvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCx6gBGc31V/hfyecy3yUNLbdqHPmUgd9GwGjidODEErOjUYBRSgSCjMq6f+LWsJbVSPrReNfgpVoI61rRULAScjAEST54UUOwgThc5ydusJjB+7zN5NeASWodo5Xn21+KYLBoTS7nfYc6sAM0da3bW4X5DHiniaPe6gTDUGOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CPWwrI8c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BjsjBw7X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CPWwrI8c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BjsjBw7X"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59SXK3800902
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9y8LDW4Y35Y8sO3NwaOEa7mBH+iPx+dPxyNYY5yZOPQ=; b=CPWwrI8cHcSZdT0s
	GuGLYjQnrYOShZXZL5uj+aZ8PPNsiN3R7Wm2tQuEhuWBbrIIgNjNABkMCSP7VUm9
	kQj0UGMQnvJse3rUQs8K9a9MtQYkFvFddGkHsk/fCkdrrM2Nmvgd80poTTloEoBZ
	5pIuFn/RlLxBMagIOL9kHFDBKbO76FjkpkiipEN2FToQVIVZ6OPjtgYyyJemMgDL
	s+H0TYZlFIblsim7RHfCNF3cyXhnpaO8MCgT/C6IkQKlSMzP01+6jJ6tvbNUBk6v
	t17GqYpOBTyR4qS1t3bC1GGgjWIhT5c5O8oKfcN+j1oN6XLJVmgmZrLY9oFpXXli
	5b3nOg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewm1k58ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:05:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91ed0e140c5so1181422785a.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782115558; x=1782720358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y8LDW4Y35Y8sO3NwaOEa7mBH+iPx+dPxyNYY5yZOPQ=;
        b=BjsjBw7XDSSyoHtX+fDP8DAoE5TTk8pNvVPnsLR90e8b/NvohwEjweJrQUZjWqvRxf
         9ev90YOzToJWyKMI7BWCabP3wX77jaXHVwJPZnutcJombCzqWwrtTGSj9SR7MZcIEmod
         746+sHq3Ct2mmxNwIT4qHRj8ZUidT/ZuLMZSp6Fr9wCk+RwdFUoiz1/MgtWhSPTZ13rh
         QGOx6zWhmdYt9bC55sd33UmaZe9egDt9CTOCrnlIYv+NmTjVcUBE9Ci+K8ORldolMxDp
         0NuWvSKnzFQ/Nar+ahLwZ395t9RqF0/sQ30iGm3Rph1yjJFsrqO2aSILF1YH8xzYsbMH
         B/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782115558; x=1782720358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9y8LDW4Y35Y8sO3NwaOEa7mBH+iPx+dPxyNYY5yZOPQ=;
        b=MM0rwWV32vxEF9Y348nKWZCXYjA4QmeF0sSTFD/yMt7qjI6DrYyHWV8jcu2ZVU52uW
         ZV2Y6QhVW04PbPrrLz01s0kiStPER43s5eSFzp7c+xYp2DVayfZh/oc+Rna3gZb6b6gP
         ZGDBGVRYRNb96m0Oe6j3xFsXoo8u45TN0hLM43VVjbf29YeUmn4J1bf2Fabx4EACCBb/
         So/XaibKBWqea8MsUN9hD9dmYWtBzH4fdOe5NobK2TBtf/u6G0t9pwAQvrmOL8Zdegd/
         obkasuXaXQ3+GFwpbRzZKcWf+1X9d0eTPLvI0+0KRN0NQwqmVzUB5Ba3qfnnv32v3fS3
         UXsw==
X-Forwarded-Encrypted: i=1; AFNElJ9/w1erpYJmBzh1BgZERBKV1pSKtw2JrscCJNa34fipN2CIjcYZhpiwxM4Nh8rT+zplIbYO7qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNMcTuoYck+RTkSZsz7YcnwGl7XDDqXAJujp4SLjBsBBEWb1x
	z2j3A17y4nxXtmGIPQttO5tIipBF+yMrW0F7QCvjCGmzI4vfRCf6wBW3/btORE8NaNWw2pfHNFD
	dMDLmnOtG1cV7HoZlS/CLcmpqXDIMGT3NfuqN90APaMTeE7Gm90EtVCSL/Pg=
X-Gm-Gg: AfdE7cm5UnL4kagnzEqINFyAydHUOwN4OL2IRIF0K7bbLPbqEhc02HRurLwZxRn3QTM
	YFR3O3N1citDP1Q+whJUkeMiTUB3f7+20NrduUb2703Q7w0ZWgc1NIU5R8V/fXHf/geR7QnysO8
	uFrELv52xWhh83i3KXm06DXRmnTSp9iaLWmPjcJqmFMkOv9lN/2mO2IKkuGQMk8ZDvYzJ6rHZs0
	ErAj7Ihx05pHApjlIIhDZuHf6kwiuK/+O8QFYZqXt0D/AN3wC9adCF3TDDaytHDTiMTWCnbW9wU
	t9YX59C0xDpdXeNNl55Id3AedKB3CwUDtwBI+iUzKekokxFExqWfG4y1jy5A3XA1IJPS0P/MYwU
	sREqLcIzS7HbqwXOLbo3OZ86irZ1UemMysElIV9g=
X-Received: by 2002:a05:620a:6842:b0:8cf:c513:349c with SMTP id af79cd13be357-9208f16113fmr2075604185a.9.1782115558182;
        Mon, 22 Jun 2026 01:05:58 -0700 (PDT)
X-Received: by 2002:a05:620a:6842:b0:8cf:c513:349c with SMTP id af79cd13be357-9208f16113fmr2075601085a.9.1782115557737;
        Mon, 22 Jun 2026 01:05:57 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm24040371f8f.23.2026.06.22.01.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:05:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: brgl@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
Date: Mon, 22 Jun 2026 10:05:50 +0200
Message-ID: <178211554547.11059.13980488492227504298.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616151049.1705503-1-vulab@iscas.ac.cn>
References: <20260616151049.1705503-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UzMUUlMqAyyOKn1yMXz0dDBJmteggG6M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX33Hnz9CX9JQC
 P7XftEtlI+/tIBofau0/Ys9QzftVrmo1CSl3RnAYRLtgFANXG1O3EPIgctKWKs/fPn8aSkTL6SM
 VL8BQN00G9W1+J0Waf8yevkAyAfVtmU=
X-Authority-Analysis: v=2.4 cv=T6S8ifKQ c=1 sm=1 tr=0 ts=6a38ece7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_NzQ_ZF5m_U5icpug6UA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfXxLgsX1dEilu0
 J2kczZwZKYofjUlo6qUJvgT5PQVT4g6k15svkuUkTxJGKXRC+3cb6FytX1+ksoOLVxCjmtX0NEk
 Axit7IsGwJ6x6bfcuxlNz3yX0y5GXQiH/3OIsgqQeqPWQsCii+6l1iVi4Xb/K85PmfRn04KEwjd
 0R04umAVewwpQV6E30H530RXqkrdz6lanvAPu+kVusPGx6mf8YfTjG3qYSMx6NJjsKpsnK9qVtt
 yKfx0dis+Wd1Zk/uoHXCFXQF5xfRBrD1xLNGcCuskI8Ta5seqTuWkgX2g2wOxdb4fJE57z+0qqF
 yzA033wjSnK/FnCEHgc1XMjAvjXb6Ng/pz633u06pVfRyCAhfEbbMGFMn+Ky3+LThl/Cfabs32A
 ty3LSKFdlsJwgMbfOKuACtGaI3zKAyX+NLXeytGpduMEKAm389kaB0mmu1qGdbgDWoJkl1h2sYH
 lgWEiKJSyGRhZE1lHtg==
X-Proofpoint-ORIG-GUID: UzMUUlMqAyyOKn1yMXz0dDBJmteggG6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220078


On Tue, 16 Jun 2026 15:10:49 +0000, Wentao Liang wrote:
> pwrseq_debugfs_seq_next() declares 'next' with __free(put_device),
> which causes put_device() to be called on the returned pointer when
> the variable goes out of scope.  This results in a use-after-free
> since the seq_file framework receives a pointer whose reference has
> already been dropped.
> 
> Simply removing __free(put_device) would fix the UAF but would leak
> the reference acquired by bus_find_next_device(), as stop() only
> calls up_read(&pwrseq_sem) and never releases the device reference.
> 
> [...]

Applied, thanks!

[1/1] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
      https://git.kernel.org/brgl/c/257595adf9dac15ae1edd9d07753fbc576a7583d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
