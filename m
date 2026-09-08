Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402139D3DA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853183; cv=none; b=KG685SaKfw2ED4SZy3qJJLvQ84BVfmXdYdKVi9lX10wAIgyn0xBEm8FKjF5Mlq4N3y4Sewx0KuZxzlz5IdAwj/A4jFC/Sk+BJgMmzeFOoT/ee4+GDXovsgpb3TM6rUPdWeX5h5+fEjyF1x2GW7rUo+oX3Dkn0vU5Xvyw0/g5scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853183; c=relaxed/simple;
	bh=vL81cJgOvudKv5vx5g7F21SEULAc4ClndxDIMCUG2Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWbCZ0lE7BMH6Wb7zInuo1OMTUItrzyS8oTep/Dr1qmU8o331dkjQh8dWlhXmMrnIs3UyR4mL5Txngd4wHErgrP+TTqS/s5X4ZiveUG2wX3s5r3sL7LOk+Q1zjthQ1Zu3opshC5Qy9jliEa+rXLceZe2ktLsrv7h2+YfWoIDEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HFifstF6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VRfhSaT7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HFifstF6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VRfhSaT7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886Lrmh2154194
	for <stable@vger.kernel.org>; Tue, 8 Sep 2026 07:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=731eDWp0YnMWLXrCZivqIdRg
	turWkNpesp1ykF83iW4=; b=HFifstF6B6fPLfEXAb5wmB4vBKuf+6i8xygebpmZ
	s1rIsZ/Clom1pKi8D8Et9vMJKXWuFVEfQC6Cq1K3tuG3zCz6H+A6H0nHzWAaKNTY
	KMml/gS0krD/4zbvT7zdvMXrwKdZ2OW78W0MslO67EK0rjneEeIx+LkaDnicVoE6
	mjOP49uzcyjWJm+DTIH47zveVRKlMa6NiTMw/SggPousd7BRAzVamA72jCZcpoDy
	/FbPRsROzuCMP/6bnoV80+u+3vrbA7AjAXby0qz2Hhqvbh/Rr62NwKRSl00PONJA
	UyLZSGxCGLM3T3hhXFTuBexOFvK+TNpErWIr1IDQj7UzBA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwj9rv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 08 Sep 2026 07:39:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93975d63ffcso478615285a.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788853179; x=1789457979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=731eDWp0YnMWLXrCZivqIdRgturWkNpesp1ykF83iW4=;
        b=VRfhSaT7sytE+0mSSpBvTIXMML0w5kbdMV8ZBQFh7SerS4AjWE+aJR60/GljBnldaF
         t1LEqwYC7oi38uoEa2sft3ua8jDRXWtNz1KJ5VJzXwSURpYywHWkah6wevvJfqMuh6Rz
         xVQ+ddYCEChC+xO1T0Q4ZKLJ6IM0j23O42cAJQkQ9qOJ6S7UNqBbtK52BLWr+BvyDSv4
         piaFhektbf2KcdxQwVTw3O0xrD14+cBRtByupfxGV7uXdjQM3V9Q5195vDLI5YEb/4Ju
         hbWohbSi9gXqS79suS4FlTKP2+zwsfZCTFOc2+jONToPZbNh2XJnk+9Mr4SPIVPJKBq7
         87Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788853179; x=1789457979;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=731eDWp0YnMWLXrCZivqIdRgturWkNpesp1ykF83iW4=;
        b=EDVU4otMiVmCFu+OtxX+OEckHoU7pNa/5/4zULDp0spSqa1nGGGimNkuoMp6UMY4lT
         q1npzFQUkLcRXtlgS4lCKrpP7L8DI00D17vmfxK0thhL2dt/QzsWuFbLpP1EHklHypWk
         eUHHW4Z96V3XXFt+F4i/tEKk3GuCmXi5CyIAnstxipOXG9lQ2cp3uu54vu84iGzEaTco
         hhMkejfAo49A5Yaq+dCpIAiEOD6zQWRTV/m5YiZWgbZeTq97+WXnx/P41D8agq2OkY6q
         FScyX/vuKJYkGvy46bPt6LPtdPqhXxWCiXz+o/51dnRZiAtITl7KUWRW1RVo2/nzEw+N
         YArQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjj7YaMa8ZtOh7bjsmRckudLDAWnCBm4Cpb166d7LB1Fxk4YElZCzs4sr5AlKipxfReD4+IXQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nrpWDZQZevgeU7VBq/mG1dqYLHAZsLD7grC2gOLohJ2fLFT0Cd
	VdhK5SNWe9Ljen6FEoIVZjgzCJ5m1C6zroTCPsEiUaVMRqIbPESQtOtbmawXwoCorObOFV+IScB
	W3EgXrdpRl9hBhzjC5xIusWmH5avJ8OJDNqqR8VevyagE5ARbql8+Uqtm7VQ=
X-Gm-Gg: AYBFou2JijDUS14qEoQbH76y+07loSmwWRRlXlNQlR7tm1fRCDSeZ2gnLyW1r/nPJd2
	EZxfk0Pi8OeE0756GZr5HeMTCX2CCOBU8JhR61+UCn2+1bKlRAuqIn7KCOxy0BNXtWA76fxSxj+
	SEK8QHmgLHjoOp4PsP0fa9ZPLHpeUg3HijiFVB5JhTAzY7UfH/+YZB8x/UB2tdl4KWUN1tn+eHU
	7gm9Jhu41eNkpGABviWY5jceEisIqq36w+ygCxnA6dkfpOT28eMOBMPAT5EZ4OZzm0NOLS+yHFz
	eg2fZvjxZnL9/Oc+kakSIaJzIO/xIL+zFuUEkgCxTIg/vhVKn6pKyJPMloiQ2qsah9UMqjbkiBi
	WPvnzE/lgEDg=
X-Received: by 2002:a05:620a:460c:b0:930:a26a:fb2a with SMTP id af79cd13be357-9398031b58fmr2707866485a.2.1788853179528;
        Tue, 08 Sep 2026 00:39:39 -0700 (PDT)
X-Received: by 2002:a05:620a:460c:b0:930:a26a:fb2a with SMTP id af79cd13be357-9398031b58fmr2707863185a.2.1788853179035;
        Tue, 08 Sep 2026 00:39:39 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48594172546sm25535999f8f.15.2026.09.08.00.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:39:37 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:39:36 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luo Jie <jie.luo@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
Message-ID: <ahxoakctfkslfiybmxgbvqvarznrbiwohr3rnu5aonmyhkrfmb@cm6mm2azcqvl>
References: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9fbbbc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=Zo5euW2OAAAA:8 a=EUspDBNiAAAA:8 a=hKUfJe5KFNZvrTfkyfoA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX0ean0axHQldv
 cACmPbcjiXk17pUesZPxyeK3Yg9kUOMkJFs0mxhN/1v0T+8p4hAydvnhPVN/ivZabsDVogVGKhH
 8vtDFgsz/A4Uv6HIXl5oDHQwdwFHy2KnPU+dls5lGTPeThGu8hSX36wHnWdGOWLvOZc3pnyg1pU
 N4w2lSajsYSSZvBI/SIO7lJUpe3nMxmQm4TzGLIf5UF850ujcdmJXQruvi4XWFiqdObe81vH1mG
 XxiO6SV70qsMsQ0ENSFqoSxgH06hXc6FzhV3qDJLoyKXtsnM0L8SMtP3sfoEyUUT5F1FP2c+YaD
 XSOoboKctk4yrZHtaTS/CrcqwYfBuAkF/TJrRJKZAyr6Nb3zqCshCcC7iJMrvt9gmeO+inAJ6xp
 JmI3tbn267sbIYu2nYGAv6cNybnhqGsUY/ikQwhhIGocP0jGRVq9kFZrm1wlyviBhYOgKIQKQEq
 C+sKS7u7MqYgoN7f6Hw==
X-Proofpoint-ORIG-GUID: O0mp8rWDzOqOLzglHir_4Yh0zXrnt_o2
X-Proofpoint-GUID: O0mp8rWDzOqOLzglHir_4Yh0zXrnt_o2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX3Uaro5ueXyeV
 NxhFYMTY+CWccEt0O45FYDjktypyyYgxwgndvim8wYIwYzbLKzgZFz03F1LnRfn/EUKilx1Rt4A
 czlbbfh1n+ntJ4AtS+ZRuUeyB7doH68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080078

On 26-09-05 21:48:25, Aamir Ahmed wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in ipq_cmn_pll_register_clks() due to .num being assigned
> only after the fixed rate output clocks and the CMN PLL clock have been
> stored in .hws[]. If registering one of the fixed rate clocks fails, the
> unwind loop under unregister_fixed_clk reads .hws[] while .num is still
> zero as well. With CONFIG_UBSAN_BOUNDS and a compiler that implements
> __counted_by (GCC 15.1+ or Clang 20.1+), this triggers an
> array-index-out-of-bounds report during probe, and with
> CONFIG_UBSAN_TRAP the first store traps so the CMN PLL clocks are never
> provided.
> 
> Move the .num initialization to right after the allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ SoC")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
