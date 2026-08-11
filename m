Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC21DB95E
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407447; cv=none; b=HmFA8nw5/+fI8M8EyWDoUCiPwqwOR4c76Q3EiAWCAFzvwn8GkgM6qfX1MeXCVYObUzCg79AFI5WPDtKl2uPPpTQyDKzfgkzEZovXm9TQ5fC+WjqhhYUXwDAx7nkL0lq1rZL/iud96e9v3vzwwU9LhGqLcckSir+XnZ5bFodsPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407447; c=relaxed/simple;
	bh=j+5JG+EDmQXkE3dTKlyZRaVpWjsDChGWdsel6FsCZI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHufB3GjZ6uorfqRDz9vwrYjYlG3ldzPOHxAPgrp75nfBBoajdnfzWYe3Mp69aOO2x/mTKM5Z3xy2b5kO22QsBvHPU16PopPFPo7GsDEx24LIhjsGWcmyMmLfH+R1MhOZSGYtt3QhRPOhhdLDPjVr3fz9w6cpwAprJ3lDwv8VYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HiaywwK+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SgkOc7am; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HiaywwK+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgkOc7am"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMqKZh3010200
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 00:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dmC99V+sTrGXu5g6gX3vzVD0
	xtaZI8Wj4LSzDV0pnAw=; b=HiaywwK+cYV+NbTUypQjEo4hVcSH9H0c03snVL+U
	dvn8vPZuyDLggfRs2hNA3Vwjk5eCQuDqyjVY5Em9SsNPO83VQCql0TQd5HurkfmJ
	YmFvql5/olFZjYfKa2lwKOrH3XgIMUvGxb5GbiisfPdKFwQgpWxJgUmAuyPvoGtj
	OQo+6pBszxhkj0rTqB0dp9sQrW4mJGuXTsijZecJ7xxeL1NWAhIx6dN/PDR8RjSo
	T7T1pb6qluCezruINNOsPymG6aNR9h9tsUsBDYmZQ1xBygEwSP1HyyGiCADUzco/
	5q4wsber+7QJAS6nB41rB7G2Nb47+gSZik+RG9Bim7D1Dw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjthksr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 00:17:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8eac2620cb0so181606d6.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 17:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786407444; x=1787012244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dmC99V+sTrGXu5g6gX3vzVD0xtaZI8Wj4LSzDV0pnAw=;
        b=SgkOc7ampvE6a0me53Th9eYrAJwGhtpY+6wpYxilpLR7KtEBPpj0Snvqw9f+XAuDpA
         rmTKSfYv7YZfCi5oqIPW/2Hd9GjjC2f2mO8Mlrr//zyaRDz0XnUsSVdL3R6bl0CGkwd0
         4xWmDSdGIklXOQ3Vm1K88VNABW9isilM9+90bhpiYaW06kyX+EHA5d1soFlrfOOwFH+9
         yri9zwJY+CMJ7AEShlIxK3WUVekIiZylLWGab0YsVQynZIBkJNXudOyQMRgvWtgkHjPu
         3t1DU8RUs3xnEiZVy1DVPMkpdeB8KSA6mReHtjWlhtPcGzi3Re17F/b1HYqWB4gBX9Sz
         SFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407444; x=1787012244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmC99V+sTrGXu5g6gX3vzVD0xtaZI8Wj4LSzDV0pnAw=;
        b=VxHdWAYNzqdnTG1hoyI3UhfbUY1aptG1en21L9YeIMbN/CBqS0GAcNnmMAaI+xTPXt
         yeGRdPJanatcyCD69xT6OiksgNwbLkoSdvjckoOKLe6y1XRKXE8CsbdGrN/REWUe+6hv
         WaYR3Wdm2d+qgzJzOi0UHpAwtPova3GYtmB3E0UvVS9kBI4hA7y4onfXV+Kq53JfKVOP
         hZCBBDYfNxqdQFZmzHD2bppUVhiBOTwsR8jVZ+ByepDXdyfBPXegPYyYlkbsSJr206C+
         R7uodi2rRhSQlduuTm+UJWB/68UcF24PQ7YRvSP5X6Tlsm+BWc+QqYJZuSPKCHlGSNul
         xjgA==
X-Forwarded-Encrypted: i=1; AHgh+RoSCIAvtWj72TsvZ7foYQn+9P2Ki5iWgKifY2FZ9TI0Ycn46oTEP0NVVWcPqK7TOXn5i/J5j90=@vger.kernel.org
X-Gm-Message-State: AOJu0YziS42uZkJbaJHp7qsIQ2Tpd9N3PXZ39wmoPQOxBptyHxfULzce
	myvMe15CQfZXMaSf1ahqTlaXvvC5FqzfEkO1tvFedllD2ROvo2BK+mt/5gbRCHoR44B3q3c2sP3
	W3KabvrhJowmFsDof24xIsVWzxb3SfFEY0S3OVy/9IykRQKxXACa1cwa5+J4=
X-Gm-Gg: AR+sD11T34KePJCjd6X5EPERwaOFYXk/YvrWEnAxXj2Bq9odfWdZ0Fr+yWbF0Aclddm
	fWS5azUFB9PT0NeYc0YL4U2VsIuz+4hqQAN1VCEmbJ172nbC6TKS/ybf9X5qE44Et6bQmMk6Iqk
	HUNPrPW0sG0Uopk8ZOZ9Os/z8Y5s3tT3/RW29+byiE3FtNXfhx6qt2nyQmSj23u6msezczGrJIz
	fupy86FId3vRVeYIhI/n6JH8zavWhL1foXUI0qhUIBZMXfTyF+JAD+My6uJ2mvz22+LBKnIPseI
	pVfhSoMiv1h39ZEwogcUtXsEnT+aQMANZo3VbV+uTvYuBObQ0/P2geUT4BIumVPbAB7bmnodAK2
	ytr6OTx9V86NmHr85JrTPCFFrJTKfU6fCNuZeUpmeanFLUBahy0l8FyLAihfH2YuOrIuImhXAJe
	2/3K+t31KdTiau6A==
X-Received: by 2002:a05:6214:cc9:b0:8f2:9be8:f444 with SMTP id 6a1803df08f44-90a345c6fa0mr303111566d6.8.1786407444422;
        Mon, 10 Aug 2026 17:17:24 -0700 (PDT)
X-Received: by 2002:a05:6214:cc9:b0:8f2:9be8:f444 with SMTP id 6a1803df08f44-90a345c6fa0mr303110966d6.8.1786407443907;
        Mon, 10 Aug 2026 17:17:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055dee63sm2270813e87.43.2026.08.10.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:17:21 -0700 (PDT)
Date: Tue, 11 Aug 2026 03:17:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range
 for Iris
Message-ID: <bkghekyhpporov7whqjd4s2oxaqd4dsjsgxn76vb7ezz67sbso@hrjpt2v4ejxz>
References: <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <27f0b033-e940-4369-aaa0-f08426aac73f@oss.qualcomm.com>
 <tdgbfewnlj3xypfnyckivnd2b6667laapkcfs2vpnk74bh22aa@obasatns3jfr>
 <MHRdGybtgutWtIo4EOZisrGdCVgOj7AdOArjfuxCXTTNcc1o1v40eltpkDUqZl5sOY9tjRFaY6tc_OKvzrYJ4w==@protonmail.internalid>
 <429d5d1d-92d5-4949-9991-b092cc7e9937@oss.qualcomm.com>
 <181b02e3-831e-4461-9327-ab5646380a10@kernel.org>
 <73b26356-8ccb-4a81-b626-a96de5b13173@oss.qualcomm.com>
 <v7vlh2lgvluvacmxora6l7u5r3cbhr4xaqqlzqdli5jympfwxl@5qsqc354n4u3>
 <7caa7fd4-6732-4c80-8b8e-a0ed99631ba2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7caa7fd4-6732-4c80-8b8e-a0ed99631ba2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAwMCBTYWx0ZWRfXzw+y3bgs51so
 jYMJHYtkcl4wvJxgMe/l4/cYUOSk4SGIyxV8EthKsbwDkBRnEQGzFWK92WupPMxsCtEjm6P6m14
 U/+F+4o0JvC+2jN6KAxG1gzEM0hb9tnTePmID7sDQJ0ku3WSBGFTwAFa/zDrUI4FBfh2zavyhyG
 G/v58T3fMYTHelxpSleoCHpIvXsBcnq9g1eo63TGqA04kEWttGJa+8bIv4rhi2n+BtRHFdBzjRH
 r+Z+VVHrwd4qUTqIPXVhVm33jkkoYUOtFNcvtN83YehyyH1cQFAgarGvOBA4KyCDfzVo+IGrqS4
 Z/JYpLMq7olnmr/oubVB9xVHpYWz7yyKRRi9RiAGOXELdNQyXc6NArZw+mAVKanMLZzRudYK1mN
 4EJNzdeNj4QG+6ZouUvJzA/QsAM81Rb12/w706d/NIA76NDJzx7TBmNh5XNkQwPkTN+a+9HPDRl
 xZJqKsEacbb5Jr8vYsQ==
X-Proofpoint-ORIG-GUID: ZJqiMep9aakPlzD0wkjEQvTKTd5fRSAo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAwMCBTYWx0ZWRfX6PXj3uAU3KMf
 Y53raw9B+dOsM+k4CYPfrQ9qLmj08oojQ3EDGTpdfCnfSCq9bYtekndhaiIIBDtR4RQjW4lmed0
 U55bMH/tSI2sEcVvuHrnNy68P/RJnsc=
X-Proofpoint-GUID: ZJqiMep9aakPlzD0wkjEQvTKTd5fRSAo
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7a6a15 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=6QnALhnPjOsiZehsMXIA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110000

On Mon, Aug 10, 2026 at 10:27:31PM +0530, Vikash Garodia wrote:
> On 8/10/2026 5:40 PM, Dmitry Baryshkov wrote:
> > On Sat, Aug 08, 2026 at 09:18:42PM +0530, Vikash Garodia wrote:
> > > On 8/7/2026 6:48 PM, Bryan O'Donoghue wrote:
> > > > On 07/08/2026 11:22, Vikash Garodia wrote:
> > > > > > > > I don't like the idea of this series, because it_again_
> > > > > > > > doesn't tell us
> > > > > > > > the truth about the hardware. This typicall ends up with
> > > > > > > > bigger problems
> > > > > > > honestly...thats all the info i have about the vpu hardware that it
> > > > > > > restricts non pixel to DMA from the 0-600MB range. The same i have been
> > > > > > > trying for a year now
> > > > > > You are not honest here. You also know that there are secure streams,
> > > > > > which have to use their own IOMMU SIDs. And some of them, as far as I
> > > > > > remember, also have memory range restrictions.
> > > > > please read the commit description again, the answer is there.
> > > > 
> > > > So I don't necessarily get all of the detail out of the commit log myself.
> > > > 
> > > > Could you give some detail to address Dmitry's point.
> > > > 
> > > > The question as I read it is - are all of the other potential SIDs
> > > > covered by this change ?
> > > > 
> > > 
> > > I get the query as "secure streams also have their dedicated reserve
> > > regions, so how does this approach helps" - This patch does not reserve any
> > > IOVA for secure streams, only the forward looking subnode can assign
> > > specific reserve for specific streams.
> > > The patch enforces a common IOVA across all streams, and is good enough to
> > > fix the problem we have w.r.t device reset.
> > 
> > No, it's not good enough. It defines that both non-secure streams use
> > the provided memory range, it doesn't provide a natural way to later
> > _expand_ it to support secure subnodes, etc.
> > 
> > We know that there is a problem. We already have been bitten by not
> > describing the hardware as is and using band-aids. Can we now learn the
> > lesson and write a proper hardware description?
> > 
> > > 
> > > > > > So, if we land these patches, how do extend it later to account for all
> > > > > > of that?
> > > > > > 
> > > > > forward looking design would be subnode, which we can land ontop of this
> > > > > series.
> > > > 
> > > > Yes it should be possible to branch to make subnodes work on-top of this
> > > > - accepting that once this lands it becomes ABI and support for this
> > > > method must be sustained, even after sub-nodes land.
> > > > 
> > > 
> > > Thats the plan. This goes as ABI with subnode to land on top of it.
> > 
> > So, do you actually plan to support both ABIs? This would also mean
> > moving reserved regions to the subnode.
> 
> How is that different from moving the reserve region when stream IDs would
> also need to move, so be it for the associated memory regions.
> 
> > What prevents us from landing subnodes straight away?
> > 
> 
> You are well aware of them, but still asking the same. Reasons,
> 1. We have been attempting the subnodes for almost a year with multiple
> pushbacks from multiple maintainers. We are closer and working on it to post
> for iris, followed by venus, once review is acceptable for iris.

I think that we should have concentrated on it.  From my point of view,
the subnodes solution is ready and the last obstacle was the
under-informing commit message. As you can see, Rob has (had?) questions
about this solution too.

> 2. Current solution, in this series, is much easy to apply for all kernels
> and can land faster so that it can fix the reset issue we have for already
> enabled devices.
> 
> Both from timewise and simplicity wise, this proposal is made to address the
> reset issue, while subnode can land ontop of this, without breaking ABI.

Or rather breaking the ABI in the same way as it is without the fix.

I'll give another reviewer's thought to it tomorrow...

-- 
With best wishes
Dmitry
