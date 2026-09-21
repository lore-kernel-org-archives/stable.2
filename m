Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB73AC0E7
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019485; cv=none; b=G+031+lqX6KP84NWUx4Dtgfo+iqSp1pZOI01w4g5YW7QbnN3dKOgEDw/4A8iPGWO8riGEGhEckf2u9/85P23BqikKZ9dEq0d3HaLh2Bdqw5H9CP5kfHVwWCZicxXfTnQmE5VsYY/HCtXSOYgTR+MF0rAGmJvJ6AJWaZK6xazNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019485; c=relaxed/simple;
	bh=oViEkXVK9OigDsmZPkXR5EFjP711e/j4sF5FEc2sAgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO9HWWCLsFXog5GceJhgkgrHFwfuUGGuy0oSluZCr5HOT7xt+4CeMqRS2LqPUD8SM2RgplusijPN7kBQh0xeyBM6Sexoh/mNVjtKcgrlPZk9Zz1rOxnQI/cpfHxFCBJbo95rfCSveIBNxhCGQYgTPaxDe9kRdpmhyRfHYZ1qajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nu5j5FI/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T4cjDUa+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nu5j5FI/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T4cjDUa+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHIOTM2981115
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yg8fqfhdOq1FGXzjyINIOF0z
	qOC81zrYO3mOQgWrdMU=; b=nu5j5FI/gFomZKmxRIbuUvFXfm965h/KNeohaYIN
	zV0cr+4EzrDG+2ZZj7wEB9dj01ndT4HStY7awYKvFMcQzwWJv3M4Zte1Mrl5vWLp
	m+tGZiSN6chVCljzf2tmGQSMY5aN1Zjdzglsnq085By00yPC1r0o7H9VrKD+3c25
	EJDwEt65h9QihfPMHQhCMDq5XLo0rexbZMNcO3m0nNmQZe+Rfp4IJ4DBM/Ec/LiU
	Jr3RNDiLTmZZMVAgUqAolRlLOS4+TGRZimw6zL7K6DKMV5XtscV3nUch5OWtKp6D
	/C1TNnW4EtLtcDgPin1RAwdDaS5InSTb/7DEmuU6JrpZ+w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8v50jsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:38:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so47407715ad.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790019482; x=1790624282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yg8fqfhdOq1FGXzjyINIOF0zqOC81zrYO3mOQgWrdMU=;
        b=T4cjDUa+LC2D1Ec8lM6e7jEAlyhoRWwcYJKimcT+5qsSKpqIeXjYSRH7wt0sY40Bi6
         YdMY7cxdppueZz7agcbRTx5DtS5i2gRzOkn59JHmsr73SHV1EGt/JHg4hBgJd/+et3zj
         W1SzpnoMdi16+xwtKT+SrTrYtsTxZU3P004+aVpR2APoeh3KXbN3WcawwT59c12yNgZQ
         uS+VdfM/I/PpZzKwzkzd764cfDgixjGJZcnvR4BDUexB6eveVK+BFoti2mkXK1ZgylVO
         L0SavqJvoWyBHVanWPde1Shgt+ehrUShZnlicPUhvVj9Y/vU0HzA2NfxCq8m89m2Bhfe
         KQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019482; x=1790624282;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yg8fqfhdOq1FGXzjyINIOF0zqOC81zrYO3mOQgWrdMU=;
        b=q3/T8NZRj0JWv05e7stw3RqSOvqVLivKzXPSfUB89cQIYvOBuSdMO+f9h4/MjqiaVq
         4yqRP5loJcToCVl5ef1DUCen44QB6+KIMXCywoMbpB92NWvGMH8ibb4E0p1dHPHeTshH
         1scARsDT5ERs5MKBymvxZdnZeD37zDfi3VR4WFNpjdJA0cAfmaU60FgxxTP5FmrhLBj0
         SpvtzNuU/ERiOkRvy1jgWZWomGmWb6XOGmIR1E8/vk6jIWt2QpcympbJZC1GjYv3ebO4
         WU0cgSC0xoiXENfHr7aWDBG9TCkDkDbSs15amsT5fzmNYrmz/u7opUGq4btSphaVtTIN
         yWTA==
X-Forwarded-Encrypted: i=1; AKwUvBwBiBXxif76+Cw2lRMLoT8098EH7w+upBi2N1iSV/clagaAbNFmzammUq3nIT9XTd34oLY2hvY=@vger.kernel.org
X-Gm-Message-State: AFuF++llZWZ0FG/fSVMkfH1W9O//MAAJVz9chH1KVPFY6VcvDUvh8MjF
	sdA127sqruScutKiy54lQy3GtinFCw37Cwnv9setWvRd22jhZYg5d/SjGuaH9gTdy+eRPTThc6l
	wGSSJYVksFvcya87WVzd2NcopQ7G+x55+JwUCiVxgxNpDAXxZjJuvuxdmfE8=
X-Gm-Gg: AYBFou2ghTnWsviWJz7WwXDREaXqVHaNqi5O2gkLCsQcWWshHVQcaOsmiD4vr+hesG9
	BOj40v+WjI7BxWl19rj9WdKwdJMVs7nt87PusiFNOWnhKpxf1y0p4s9aAWjLopYJFw39Son9yUW
	QZuJOOvgz+xBWhyGkvmVX/4gzk3JykjhzFNC+I6//4q7uhVfA+5Yj9kxezT6hoBXHb4tz0WrD+G
	xtyjEBtNgQwY6hhbSvkcvjhV9nX89l89XnXU+maOMqevJrvWpXK+PZa5VPgZ7eNx8pS7hGQ+bAo
	9Ti8Oxzf/eIuhlExZ+Itr2QRBW4l7Ov3T+X5Kh1yxlNNw8BTbsVJgY41b7c8tKQnjz8YJ2k7e7A
	2yv7TZxgFJbhupyzC/KgEP2kmhw==
X-Received: by 2002:a17:902:db0b:b0:2dd:3ddf:b87a with SMTP id d9443c01a7336-2ddb16d5a08mr177252075ad.0.1790019482307;
        Mon, 21 Sep 2026 12:38:02 -0700 (PDT)
X-Received: by 2002:a17:902:db0b:b0:2dd:3ddf:b87a with SMTP id d9443c01a7336-2ddb16d5a08mr177251815ad.0.1790019481787;
        Mon, 21 Sep 2026 12:38:01 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ebcdbd8sm288669eec.16.2026.09.21.12.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:38:01 -0700 (PDT)
Date: Tue, 22 Sep 2026 01:07:54 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: fix wakeup source leak when crash
 handler sees RPROC_CRASHED
Message-ID: <20260921193754.2ulkssymszoz66oi@hu-mojha-hyd.qualcomm.com>
References: <20260730085437.1240215-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730085437.1240215-1-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-GUID: HFav_fYD66BHb2uOcRT4rg99emKiMo1T
X-Authority-Analysis: v=2.4 cv=B+0sQ+tM c=1 sm=1 tr=0 ts=6ab1879b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=W9w1WEFyLmScbr2sSkQA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI4NiBTYWx0ZWRfX86IXXDhAXx9L
 NVxOItLBJZfTw786myiORXmndc77xcOHgbxD5rE3WGA91M2usDIgoYQrEkXzKTeBg/2sxx9CRGD
 8bjbPdKPKbYYj7wz2jodbr44AIxmN/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI4NiBTYWx0ZWRfX3uwmIcyiwU4h
 DjGNttPiQICSfOj1JIDef2GFST+QOXbo9GlkanikZ9i/0JGch5qMqdG0z3ncWu2zdiZe1TDEckW
 favjrGmk4qg0sS4MALuOVlMbOtkCev+q5Y+9HRfwbhxWsw1PB4zMc5PTlDvG+ug6q0/7/pUMxt1
 FizO99CfJPyWt7WB1aUhr0BsgsqZVDISInqDCn0mzO9VWcgYwb8Ljo9t+MElFfq+uPegPF3LAiC
 MhwN/nUFMHhuKYBlRKJjUiD45uufDYF5X4uWB4jEoq8FhfkKIO1wgG8edGS95KD9q0It0u3oNVt
 FEWTfiqWHP1rmTRbmHRxoKGPgf4h5AEUnpKpp6v+fNs+fARNBi04DOfPoQ/7S9Kz8fxsAaYDeaG
 +F+1exwl+AuQ5aSj08BssopaTr8zAHDDrjuGzKvonbJl1dYkrdCpL39cq275193Db2XMt8GSW//
 hYV5bp8D06sWkksaNHw==
X-Proofpoint-ORIG-GUID: HFav_fYD66BHb2uOcRT4rg99emKiMo1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210286

On Thu, Jul 30, 2026 at 02:24:35PM +0530, Mukesh Ojha wrote:
> When rproc_crash_handler_work() finds the remoteproc is already in
> RPROC_CRASHED state, it exits via a bare return, bypassing the out:
> label and its pm_relax() call.  Since rproc_report_crash() always
> calls pm_stay_awake() before queuing the work, every crash reported
> after the first leaves the wakeup source permanently active, preventing
> system suspend until the device is removed.
> 
> Change the bare return to goto out so pm_relax() is reached on all
> exit paths.
> 
> Fixes: a781e5aa5911 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Request for review, series still applies cleanly on linux-next.

-- 
-Mukesh Ojha
