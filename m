Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755EF317173
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026403; cv=none; b=PoF74MkV8iCbAN1XLwVM8Ggx2aNv66RWHoaY6anW95ZikMyxJy0CousfCD4oG7rwfzCUk5s6Xh9FA5viFb31M/vmXhPqZm5rPbf29gDS5C1OF2UXWLrFje3L5n47oU7PppbxZkFvKSW348Ja7XqIPbW9eqO82Uv50h6rGMC2iFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026403; c=relaxed/simple;
	bh=dH+CKXyME6aDU20HrXr6nxftkT+Bm7QeUvs9ocYmto8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EvjRx4hlxF7r9SJbF2bg1zzFDxCBIcd6ngvjYO1znuIuE8ELwiZxwsVbBgLQ5Nksdg9r7Tx9T75/s263qxoItSrvj9te0+PqPHVSReURZtQIXYio2KLzQ75OPfcAjj4W+1PblYTsL14Y8lVgJ5la1LbUgVB17SjaocrzeV2JdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfOhZcSs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jw3l52T2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfOhZcSs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jw3l52T2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662IvhWE1259759
	for <stable@vger.kernel.org>; Thu, 2 Jul 2026 21:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mcKsepWyNI3nbT5QEY3VlLdyd7IHG/djO0xrjG5CLZA=; b=hfOhZcSst4CozBRV
	T7NdwbRbWXwTM/HKvyjUA5149Suz8puIe9JlRT7hPKp0ZKYrTVm4LSZKBL/qt8Hz
	teROrXeKcIoxA9SXZy0WBxh5nBQsvPpLVhqIwgki+gqp9LteVuTpSxAaSe86oiYq
	YyJnvR6Fo+a30EdY30Ka0OgOXgBpYzmJw2UuIS4mgeZi4RoRHeMvE+by5seoTMV4
	HZg2XqqKBDdJKyf55UFIStlYocEwkmY5V3WTKD83sBrgYeaieX033YQZbcEL8rM2
	SGM2dAEUDRyxKsB9HWcnuyG4NXVZYO23WzPF1KXMpCQLl5+2ZwioyZsDJWyFfrZX
	RMdnjA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98krka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Jul 2026 21:06:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38101e6fc6cso1163323a91.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783026400; x=1783631200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcKsepWyNI3nbT5QEY3VlLdyd7IHG/djO0xrjG5CLZA=;
        b=Jw3l52T2XWNlrvGZKpVfepS9O8jXwMN/67RA0I6r3wV4wayNwdSWual/a4c0fHUNzq
         eLkbuhFjxIcrv+yZrV/ucq8VQwUCyV36HQ2l6VwnqbtVA4aB1OsUwxHu2VTMJdm87TGl
         PVema907+NARt1JIn/z2yK93aZ1OwSD1/xn1fDNOGpcTAtsaWUpb1rTjaNwgDylmUVnI
         PKsQLhnr0OBdDtb6dcleVoX1XTtaRTjTjpeIJPHyk4so4YvJ7af75U9yQnddzmcbqQTz
         lhPNTpomL9jLVwVWIbyCNzvPWv75hjR+jAMBCEXzyp1MNQlnMfIDqoXVck01gUF4ik00
         hgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026400; x=1783631200;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcKsepWyNI3nbT5QEY3VlLdyd7IHG/djO0xrjG5CLZA=;
        b=XtkDVd120bxoTSYLzjeSsBziATtRcziAhEE26H+SMu4mp4Rbu0/Lr6BrcGIcGsXU0e
         1qHv4yRH3sVfNOtlWJa9IGSSYQ9LaBGzxeK9XA8XasbGJDKzckZL1NK/yKRpLCRwQrnk
         eK49jP2nXWLlj+8w3rOvkmBiaNTmn1OQ0FvBgUSr5eAApL6w2MpDE/GFmyspVrzC771v
         kjp88HdWWvcG1nrt+FONRq6xfo7U3/BLoy/6+fpbJFIx8fIvmew1YWfP7a9LIXAK99Mu
         9Q/hDYsmzkjFl9UhDIJdIq/VZWsPxh82QslUmhZpRLRw9GuJTy7PAt8bktZbAtvm02gO
         Hb8A==
X-Forwarded-Encrypted: i=1; AHgh+RrZpaZFhb2JtyqwbZkekSY1flHCCMxQakQv885S5DSImwO8KpailzfpeOlLzK/UpQ55AwPRd6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdtToULcRWS3D3MB5DT1U3Tkjk6sreusrHrrtt5VsTqtJD1DW
	91gAURvtVgJcJRw88jnlYk27aJDlwxoZX8Q5UtFY+4sKL6V6S5q0aE51SLA+yiRjIMrs586inCL
	na8B14tINf7v0fAbmScc5/zWzrwQrug5/UNxo1zzh/r2+hw7nqOrHt0pdSURTNBIc3TM=
X-Gm-Gg: AfdE7cnnhZOzg6BtBuLITU3aAqkMyi34ZkqmdSRLAMuTzkA65T5cKTlQbh2+5Jt3WF9
	27yJ72YnsKu0TIgkgm8rTZuvLTTYXBl6PlVViYh6JmFDEXd4vfEexJQl0CfnOs3afEFJ0XdwDS/
	DZ1AgkpHFy1wIUS4TZWw+cLzWoLqLmSEBHZimORSK8MEM2mAMCNccPqA/6c8F1YeUzNdnL0ktHf
	Rwmy3H0AulVQg+EYCSESM3nQ+tPCA3qxcfZW27viufiYXKEQe2oHR9ar83ZK4O+oS0QNopJY9RO
	HZMTQdih3ZGk89Cy78fLX46dFAwysnlx619/5Fg9hnezNqFz91tpFFqYzw5qhvtzAKOtvMI0+Ru
	3nXeXVsLlCUlBvQYKTYB+4EMkxOYtpfb7OruBAEolPsZd3sR6yXiA2VonHIZANlB8Ag==
X-Received: by 2002:a17:90b:54cb:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38121c17f88mr409713a91.15.1783026400386;
        Thu, 02 Jul 2026 14:06:40 -0700 (PDT)
X-Received: by 2002:a17:90b:54cb:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38121c17f88mr409660a91.15.1783026399822;
        Thu, 02 Jul 2026 14:06:39 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7bb8fasm12300233eec.1.2026.07.02.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 14:06:35 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Daniel Hodges <git@danielhodges.dev>
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, kvalo@qca.qualcomm.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260206185207.30098-1-git@danielhodges.dev>
References: <20260206185207.30098-1-git@danielhodges.dev>
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
Message-Id: <178302639490.4076904.10429131082562812583.b4-ty@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 14:06:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: x_f-P3vzTI8OYaAvNxU62zultE5llAN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIyMCBTYWx0ZWRfXx5WYPhke5yDA
 XDLMAQfBV/35jPXEEa3GgS9YNjBmBEUs37HfRDww8tEpzVf6wZxb0GbtCdwekKE2O8d9KgGDMyv
 vZcQB+64hS4Pma6TOEAxwEJQJdGqbJcHC4o2pFKJK/6tC8eaGKM+m5KQO7rfLg1Ye10wQUM+s+5
 6OyuBP6vut0hvZc5M+U4dR8LSa+6NF1KzhkYCs0ACQs7b2MMluKDtD/vLR53PhjMS+ZMf73Ujjj
 ysDFFQAp9aUlGkqHMQHt8Mae0jxqjiQrAHxh5br63knCtd8bX7F5BQAjBrK/mbKbFmAXXTj2G//
 BkBQPk3cxPgiwB6C3EpCJqCaf/KU6OM+b0+xEW7g6lsChdXJeLEzYdRvX/vPr4YUrR0jWRKmzYE
 Y4vvcaVshyGqJPwHlbzl0EiGUcaySiCudQ0FpFV64XfrfAd0i/ht1LR4Ego1nVyNLHy5DaFwTDl
 mQnnaMp10nLp+85laFQ==
X-Proofpoint-GUID: x_f-P3vzTI8OYaAvNxU62zultE5llAN8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIyMCBTYWx0ZWRfXxDWgMOtCXe7B
 ulByU5Y90vxJJ2sVN50ozCBd6wFC4FgaJZCmiEPbaTm3tX9qIQtfBbLbHo0f2Rr/ixuf3uVjXqr
 3sFz3afEFYKkEVBMqs9NYqAR1/Ece4A=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a46d2e1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tfyPAs_2uK2ulwPNWpMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020220


On Fri, 06 Feb 2026 13:52:07 -0500, Daniel Hodges wrote:
> The aggr_reset_state() function uses timer_delete() (non-synchronous)
> for the aggregation timer before proceeding to delete TID state and
> before the structure is freed by callers like aggr_module_destroy().
> 
> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
> is called, the callback will continue to access aggr_conn fields like
> rx_tid[] and stat[] which may be freed immediately after by
> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
> 
> [...]

Applied, thanks!

[1/1] wifi: ath6kl: fix use-after-free in aggr_reset_state()
      commit: ba7debb4dd6427386862220e8335a53a4bfc235d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

