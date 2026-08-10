Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEA3D7D6B
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363817; cv=none; b=Zk04iscz4E+JhOttkWfHufqXmWst3TX73DRWBNZ8cyX7Dm6lBh40y+2cbgzaSaymPTHOqGC6IKBnhhQtZb2q62IjL2uV9S6WjY9jkpHoYmIj9OCEx0TSN3OdVobisPFy4uuP0myd2mVTM4vR5R6WN1NYoqlXQs6VcG70usCQY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363817; c=relaxed/simple;
	bh=e8URI1HupHz6cZ5X4siEkWj2LxOcgc5bMkMhzNHrXH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Quw8H0+ZJrZ0+D9zia26aXUfudXV56+xltdVDY/CYC9gs07J0F0QR8AoZTagIgtKtdBg97dnNZvf/Sm4FXQx1/xNEX7mNI1LQlzqpeO0Lks7k8U9x/nIwMP/5hOH8OGg/jWWIey7Rm4hMpiHZKKXQigAFJLrzUWBpA2gDSSiGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fHdYMOFg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bkva3JPn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fHdYMOFg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bkva3JPn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9SUct1119620
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rz94gqtfLhb3foxkB1808JzQ
	JTuxGFnwz5wYt82+rAs=; b=fHdYMOFg0kMhtcYDEhUtw9CAQy3DfjNvMU95ZDku
	lwWwIzQMiRjeESpvQggjqh3N2nS11a+mS2mR0Egtnzl3pB90zhgyLvxGXcTniV6M
	j1R9oBDewrskfgR8cclmhpY+jnvI39QmTlU+dautgKY8X66dm44A6Pe5i6F9VMCI
	3bK9FzQdL6ZbBEnxQJmvIIjJXsJcXpPdD1iGdUafXj3X/X2IeOLBLR+JUF1hyWff
	hj6/GqmVDddkuqOVzcjFALVjURQGsy2xgY/KbxgAkxxFNOHbiwN6GBZR2tFDWk6k
	GSR4lQlUQQiwVmsgsVlXVnU+n0hfbnZkr81ieAVdPIgy/Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v6sf6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:10:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93106d8affcso150654785a.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 05:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786363813; x=1786968613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rz94gqtfLhb3foxkB1808JzQJTuxGFnwz5wYt82+rAs=;
        b=Bkva3JPnXQOIrGhWkXFQTslHHCkgPphykBEac/8KESRsYkn03Vz4lk3IkGZNekwPhi
         Ty8EOfrPsGnCmDhhTT6vcWWqd8m75jvbtnagNjLoTX+HZ/ymJxQkkY2Eqc4q5gq5GtmD
         LNw4P9MLqMQKxUXjGtRI9k+hAXBTNU7Bp7g+8PGBiU+DsURy8TGFLgSy1Q0pJLKPjCNd
         4KBpwruad4sAB3/6qA2MCGHbkajNQJOHQVpOuYHIgFOsWg0rVsMdtcHQpZ2+4CV6g51O
         7BEcFQ/9xbVpirYXauOlpF4vEP2xb2V6Pnztf4rnVjtq5goyzfMNFLaMq6VP0Wg9s2ib
         J92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786363813; x=1786968613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rz94gqtfLhb3foxkB1808JzQJTuxGFnwz5wYt82+rAs=;
        b=EbM8AUiqZQHIspbnxdu8onJE6HoIb1Kd7ofEhNmHnrTwbgShmzXGfXI4DUGRI8jKXJ
         OwOcsY2/ro54P+Vb1tXt7H2C/YFoPLbbY8mlW9ksGP6fb1eSmgCk0/hT9li2/3YI8/k+
         RgYrkZCm5GcKlX1Alxggb6v99iViKj8/vSZdLqGwu9af476JWlyw39OZf5/mK+xuksOo
         DDIroZfBNgApQukhg6fMNFbmJHLcmAf2YqUTi3x7f1cRmHyF1JSGKIl/D3hmiwiUMgpm
         9+/Zw0QW1PfUsF8zyEX5Y0QeI2cNgIKHCMhWXXDWGbwKZ6BqBG9TXMnNnvqRVmQyeQxi
         2D6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr9eqkQct6T1bTYjIHs0FGpiLyIJhJolgCHLBlKZhYQy8bXvnrXVE/O7MxIlgqyXf41hpayLCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJZuHQ5LSl/y9mrmPaMKkLMciezKF9qCSbs0RJyOp8uFRf0XI
	Mm4xqwQZqAhw1VrhmLIDF1/D7mtO83M+N4beuvobFZqS5mPGRSds4WKCMFxuv3jAnS33b8z7jA7
	3nitokG4Wgz56fuNRbBl9Hb/yXavdQi3IxToWiqvXl5m2TM6+0bbHFy8nfqU=
X-Gm-Gg: AR+sD11GP3OVeANBqdJBcBKHnGHvGdoaqTPU8uMZJEU4n0ehjhjEi2TFbbwKlMrShvU
	cuI2P7dnju0N6DKIFa+sTbE7xla+tYrGmy4FIfQz8N/WUq+69wAeapQFsiunREQXKZiPPRv2eeu
	Bxf01HOYg4jbJNhbggC/MPAQGcBQwY4Z176rvm0QFVn88ZkuU3wBap/jq9ziBUqcWgZ+6GhIcfM
	N0POrbhD/YCheDJBJpAdTwQwSda+IKQoGfHpmH04GY3Ju+8tgIvfEs0fixLpWOusfG286kJSyvE
	m/0HzHqqFXvRAAZOzUP5Ji9kmP4S+RmM45S2cnxz5sya6An5Ae6bHY5G+H6jvK7sASI2HNz7Icr
	nPbuiGTTjA1XXFyNCg6UNxy+qPPMoec+KkuAc5YyW4TgCH9pQwQxGP1Mpgx/AtPjeE2e0XCcm6I
	VlWsD1TH8z4PaFQA==
X-Received: by 2002:a05:622a:58c8:b0:52c:dffc:4645 with SMTP id d75a77b69052e-52d18e1a66amr240979521cf.7.1786363813375;
        Mon, 10 Aug 2026 05:10:13 -0700 (PDT)
X-Received: by 2002:a05:622a:58c8:b0:52c:dffc:4645 with SMTP id d75a77b69052e-52d18e1a66amr240978421cf.7.1786363812742;
        Mon, 10 Aug 2026 05:10:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3056f13cfsm1913261e87.79.2026.08.10.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 05:10:11 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:10:09 +0300
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
Message-ID: <v7vlh2lgvluvacmxora6l7u5r3cbhr4xaqqlzqdli5jympfwxl@5qsqc354n4u3>
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <27f0b033-e940-4369-aaa0-f08426aac73f@oss.qualcomm.com>
 <tdgbfewnlj3xypfnyckivnd2b6667laapkcfs2vpnk74bh22aa@obasatns3jfr>
 <MHRdGybtgutWtIo4EOZisrGdCVgOj7AdOArjfuxCXTTNcc1o1v40eltpkDUqZl5sOY9tjRFaY6tc_OKvzrYJ4w==@protonmail.internalid>
 <429d5d1d-92d5-4949-9991-b092cc7e9937@oss.qualcomm.com>
 <181b02e3-831e-4461-9327-ab5646380a10@kernel.org>
 <73b26356-8ccb-4a81-b626-a96de5b13173@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b26356-8ccb-4a81-b626-a96de5b13173@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNCBTYWx0ZWRfX5SdB+01uYxZ7
 N6pFidQm44uv2eq8Lmr8kIyJ32K2Cf1a1hXHdCTDDY3cgewSImKY04CvSv0GmwzlFXkQ4psDcpn
 wPj6U47eLiRKavCgA6zeEj+8dlvmfQw=
X-Authority-Analysis: v=2.4 cv=PvijqQM3 c=1 sm=1 tr=0 ts=6a79bfa6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=DL-TQF8ImT5wUrRkYbQA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNCBTYWx0ZWRfX6p4EImBpXDBb
 P/o/WEf8C4MscKcxSPpmS73l4VlcYoWxJ0d5FYiGOi+orspRZCpAK1YkuymtM5eoeYtr88eUhq7
 1dULY7Hjvl0GDwcDD6MJ8gOfOyhJ6VUay+tOkyFAoOWM28+pxkfWn4f75P+7SpHzsKGFPl1dTY0
 VAxO6oivn1VFzisRCL1FDpnkbIoNEeUMnWHEK/VRjkMiKsp9FvnN6g/u3K19J0wFn8ypKkb9qEQ
 Dl2vRrlSTyAlen00dG2GiIKHby/BO8F1NGK9kbD4/2cxbrXx3XGbp8XG33B8LqWjpkSMzh4bRKx
 J7Y9JXzrqyB9pHcQ2LiHknrCKNpa0VeowxHCGioBSmGGf7LiXDzeZsbQZhB/5EZQj7leMQE65lB
 INNxY+ZMMmL1IaVpk3JkuYMmhDaOEC5xqvQGjQHPqqh+C/Yz3X+JY9fZ4EAVOwLZiSak6958+49
 a/5axjkeB8GAUdwIQ4g==
X-Proofpoint-GUID: VXzl5JuzP91CMt4CLVCIxdwNi_ZGryaZ
X-Proofpoint-ORIG-GUID: VXzl5JuzP91CMt4CLVCIxdwNi_ZGryaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100104

On Sat, Aug 08, 2026 at 09:18:42PM +0530, Vikash Garodia wrote:
> 
> 
> On 8/7/2026 6:48 PM, Bryan O'Donoghue wrote:
> > On 07/08/2026 11:22, Vikash Garodia wrote:
> > > > > > I don't like the idea of this series, because it_again_
> > > > > > doesn't tell us
> > > > > > the truth about the hardware. This typicall ends up with
> > > > > > bigger problems
> > > > > honestly...thats all the info i have about the vpu hardware that it
> > > > > restricts non pixel to DMA from the 0-600MB range. The same i have been
> > > > > trying for a year now
> > > > You are not honest here. You also know that there are secure streams,
> > > > which have to use their own IOMMU SIDs. And some of them, as far as I
> > > > remember, also have memory range restrictions.
> > > please read the commit description again, the answer is there.
> > 
> > So I don't necessarily get all of the detail out of the commit log myself.
> > 
> > Could you give some detail to address Dmitry's point.
> > 
> > The question as I read it is - are all of the other potential SIDs
> > covered by this change ?
> > 
> 
> I get the query as "secure streams also have their dedicated reserve
> regions, so how does this approach helps" - This patch does not reserve any
> IOVA for secure streams, only the forward looking subnode can assign
> specific reserve for specific streams.
> The patch enforces a common IOVA across all streams, and is good enough to
> fix the problem we have w.r.t device reset.

No, it's not good enough. It defines that both non-secure streams use
the provided memory range, it doesn't provide a natural way to later
_expand_ it to support secure subnodes, etc.

We know that there is a problem. We already have been bitten by not
describing the hardware as is and using band-aids. Can we now learn the
lesson and write a proper hardware description?

> 
> > > > So, if we land these patches, how do extend it later to account for all
> > > > of that?
> > > > 
> > > forward looking design would be subnode, which we can land ontop of this
> > > series.
> > 
> > Yes it should be possible to branch to make subnodes work on-top of this
> > - accepting that once this lands it becomes ABI and support for this
> > method must be sustained, even after sub-nodes land.
> > 
> 
> Thats the plan. This goes as ABI with subnode to land on top of it.

So, do you actually plan to support both ABIs? This would also mean
moving reserved regions to the subnode. What prevents us from
landing subnodes straight away?

-- 
With best wishes
Dmitry
