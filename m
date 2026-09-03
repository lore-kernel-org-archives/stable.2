Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864E3CFF77
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462170; cv=none; b=Zs7dJT57O+WvdN9YnWj+z8h+m5xuPADeB8GF1psw12hwQTVrOWt2FN8OBn33MgIqa+XB2OMyHOhOArF18GKRJUiqKq/xppE9morvgoRNk0pZ6O3iKGZV8PhVHKgC91pCg7VD7k47ZRJoQ9H2kTEsCqAzNHM7NBF/1A4g2RJmrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462170; c=relaxed/simple;
	bh=gsd4KWtCsBvu5WSWvwFSKMFeW2aHCI2LbDE3Kp+Sbkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tIcJw/hLva4f7oSbHT5EWLxLTLGV1ux+Oh4ZF14dY5I6W26byqCixVY9rfjH5TOVt6swppPIy7t25j6lyzF0zZuaj/7apheUDyvWATLjwvR0MH2NwXjUyhnwU1xYrq994/HdjfuCdjiCAP60Profjc8Vlz4hP7WRYWGD89b7UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NmSHvHWY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVlDitc4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NmSHvHWY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVlDitc4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G39q6927747
	for <stable@vger.kernel.org>; Thu, 3 Sep 2026 19:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1eeL7lzBwTDAvHtt/OIh+AAbkDGWXDc+4IzQjWdsxnw=; b=NmSHvHWYB+vCIRfW
	Zh65/AzBrKTVGmUnXZ0E7b4vX0XXmNjcU7yHgvLRsItKGN7J4EycM1Qi18XhTmwX
	8n4bUhNML1Npv4Pu4ngNLHatq5rZquFG82M19rKf13LOOGyjYNK/opFfLeSnPvxj
	p4VfdYpug6yD0TLqZazxqWT+K+JoEmolnvmHaINFfcilvJHp5Pn3DA2mAu0jg4Hi
	X9zm7qBK9HVLFvOJUQ/zYvpFmEYVlpkCE2MZKLXe5GbcPC5tYfTgaA/EnTACCHr8
	KU6+XEgWW0fvE/5XGPSL030wC4fbbbVokPmDIPU9YQoSwLDOPSmePryUQmxEZQc7
	6Gb6fQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx2d1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 03 Sep 2026 19:02:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39906175917so152588a91.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788462160; x=1789066960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1eeL7lzBwTDAvHtt/OIh+AAbkDGWXDc+4IzQjWdsxnw=;
        b=iVlDitc47AjWjbSLUx/zSLnsPU71wquWuBuNSh4E97aFPPkRiw6SSnRk2YJ7LTbDJy
         RpYSPl9Y0BYF0jUgN+XQ73YxD1K7mFZ6/c317weM9YQwYGcMHAUR/NkzxFOM9mE87R89
         Nc2RtqEWwC1sZWxii6uT1d6Ysm828iwjDuDz7eZxoTXwk+n8vW6nmeY9aJfd4axcOe/c
         ir/EybkZ4yuI5QWpiYJAKSf8dvuO6ysdhCi01UIVeruUIjdrtLli+pgvfq14+SZJUdu6
         WBxsLm/yFD6xwQK3cwCeFPOPIRMaXu8ucFLyYN1OeBW5eobyCsUqSAonO5516o47BCJL
         lOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788462160; x=1789066960;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1eeL7lzBwTDAvHtt/OIh+AAbkDGWXDc+4IzQjWdsxnw=;
        b=JwTS5h+dykV5Z/uzHERE4ReHChRAJ91igKFmmT13kq2/c01KnAERuqLYtx/T5ZMPAA
         TzcN9YxrR3C4MNAUasec2ICBCwVXpSrKHUxXzmGLFDKu50j27Ys4LIhSfY1FzUjmKUjO
         UbJjiwJoaFuefkdLbjTqSyvgcrSKEwrK0VtJCe0Ycm8uZ/Y4K1/iwLha8WqE8Gv2N+hn
         tKTgrcQd9mOaizaSzTJP4wQs95/BWlmtiHDONAE1IKKXEaiqWwUxGAJIrnktsFNzO+VV
         WiYMkh9LrwhlCBGG/jNF28X9EAh1KsaiCz/PCrQ1fxCF8P+qr6iz5B02li/XVVipF1Vn
         4+AA==
X-Forwarded-Encrypted: i=1; AKwUvBw4StwjJgXNGj6t3PVuXJL5xR2p3/zICR+IxMSkkL6woDbk4WOVg5PifaIgZ0kvCyF1H6dLc40=@vger.kernel.org
X-Gm-Message-State: AFuF++lAH9iH7vLEUIoqz/g5vChbUzRgqo4ooYll6+VKD9miKA7Zmakk
	L3rk0+h1lGxGDphNkUEDBMX7E0Gc2AN4efwtvnf4qyizU8dH3BHcqTZSocqtLIJDQ22iMfMr6pn
	oCZypy8jzHGMKUDlEE/FhTY8VwJ4Aj7F04g/dPZ61/KBnEabwXNrLIoFAGC0=
X-Gm-Gg: AYBFou10IU8Tv8uRP7fP5Cl/d17BiM8HkEC6tfi4kdv0Kuukb0kg0QQYGBnflZSNGwK
	zLqcqgju9WPQdoFggS/0k3kUn92YEL8iorEpJqEXgCgVZhbDl2PpEmNW26gjpu+Dlkhf9Kw390R
	liH04Yivgnap61SjHtxWMcg6TIbhvRblYoeJwqRkNruUmwSj15GHTF1pSpwiOchl+esRIa0vcPn
	LomfPxVE5FWFumm5G3Fs8j4PqnetFIPKrYTLq0Ukkl7iFbhfz5abTVKawwzNyUncS87eZ7Ppx4q
	v+5LN7ly+7qUioXsnk77wnctqimcXYMAP173ITs40xjz41q8aB2UxWee+6939PMl1Aq+1G69mkx
	65Plb+OT0a5hrH7tzquAmLEV2VZeEooPKO/SqPeMV1QfDvBjXsey5Xtk=
X-Received: by 2002:a17:90b:54c3:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39b2612ecebmr977403a91.9.1788462160113;
        Thu, 03 Sep 2026 12:02:40 -0700 (PDT)
X-Received: by 2002:a17:90b:54c3:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39b2612ecebmr977271a91.9.1788462159534;
        Thu, 03 Sep 2026 12:02:39 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm1230164c88.11.2026.09.03.12.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:02:37 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
        justinstitt@google.com, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, baochen.qiang@oss.qualcomm.com,
        stable@vger.kernel.org
In-Reply-To: <20260801114911.91483-1-nihaal@cse.iitm.ac.in>
References: <20260801114911.91483-1-nihaal@cse.iitm.ac.in>
Subject: Re: [PATCH v2] wifi: ath11k: Fix possible memory leak in
 ath11k_dp_srng_setup()
Message-Id: <178846215711.824911.14716922396673159484.b4-ty@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 12:02:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: uYP0xZu1R4ZlGOSp2TS7WUsZBye8Df32
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99c451 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=znwm85vKAZ7j0MCq4kIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: uYP0xZu1R4ZlGOSp2TS7WUsZBye8Df32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX2t8Wo5RiPkPa
 PoweBhMj1p7HpZ7j4szu+AKvyGysPOOHhF5cVkBvfI2wwkFZ+SCaDF15zTBqXOis85i8kzqsnlA
 IMxKwW1fVqTJv2v30/10WgD14h4wA0ht+WIyvwUXPP7Vt+N/saR72VBEgS+4GFRwBG5nsqZvNfO
 jFiviS78gC5vQfopcsFKwdlHll9tinH7HpSBMTFwwoLiUFb5Z884WQhdKmiUPM0uEk2jK4lRyVt
 iK0/6xXFJ+CzK8Lx2w10Pzeh/Onaptj7+txTzSM1xtG2xANQI8Zt/pBIpRmuyUwTRqSzHz4Wcfq
 WSif2SkdFc07WAVckPCt4kfXe9uwwlqwuJo1w7QcdVRhGGuhbrU1+YdQuloxb66d1rfS2d8LdmY
 FPGIAEHjxANT/Q4C/huhZGmaOpWFY77tP6vijfuI1JVZrCm03F+/TOYrZeSsEcfGJ0dAJN3VFHe
 WRt+eCHWh6BJd9569KQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX7FL4k3U+h2oQ
 8vVtowaMZ4LhQyzaHaamzIkTUb6FQtWd9LMJORneekXH3FUymJ5mCbCD3hgbWm1gJsAgusXovtz
 +M5BAw+btqde2yPYu1N5WB3fdyctHn4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030166


On Sat, 01 Aug 2026 17:19:09 +0530, Abdun Nihaal wrote:
> In ath11k_dp_srng_setup(), the memory allocated for
> ring->vaddr_unaligned is not freed in the error paths that follow.
> Fix that by calling ath11k_dp_srng_cleanup() in those error paths.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> built on the LLVM compiler infrastructure.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()
      commit: 6132d70d0890c03546f6970893fd71938efb2a2f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

