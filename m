Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407126;
	b=NtgWTzYvk+u8ZPxKFnaLwDrY5l54fYwfktTR18K/wckqBwlrQ/Wi97GFyCKR7fkrHFV9
	 xIVFBL4xPccmC6RoHcQDOFvNMRqg58AC/gnmuZiAa2LcMH9IS9ylVtAUx1OmJ7W9jl+6z
	 ngpHcGvcP4grN2w7xq7hWzLen+3xAmofzssS1362Lh2fDIrhMffXKGjzILQhd1pssFb1Y
	 chse/go3jjIomAF4BFW+EJVR3v8csH6N64vIgPKSpgfIx9zkXL3rcDdM9KAtkHHza9Sob
	 vmGu8DhC+z+njD+5idDtpM0Kpm84YZJdkMfTM5Md31p8ijV/uLyx686grczG0re4wgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407126;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QHCjyWnjJaKib08TgPofPSfS5d3rT38/26nHs0v//to=;
	b=i2bAOoUnzICPNy3iVd+pofnKak8Klnyy0N1e8N4seYCkSAXdYWDCEo8lm0DuvQdukydG
	 4dc15y4DZ532Rr5c8kYL005kVTcgAYa0kDZc281fI8P0+vtlqCyCGaBFZOVXG4VZXo1Kr
	 IXAHMeK0m9+qSOe0wg/LotP8MkRS/aOaJa9diyn1Eu+F3S2xqk9f4RbE5dO1NYxHQ49TH
	 tXt8dWnkNDMi+bp9nyhwfRGFwC3Yh+LMApkPthCWhGhH4tEPNmIbcUgp7HPrDkgWh+kB2
	 YTdIZshEBwAsj5gW7hTerAGBNN4bpDM2dqHD4uLtBG2iqlNSOcJq5NaYiBwGlgLMXfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jePkFgnE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="kq9kU//7";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CA606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 848CA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jePkFgnE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kq9kU//7
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABEJ4P52223441
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QHCjyWnjJaKib08TgPofPSfS
	5d3rT38/26nHs0v//to=; b=jePkFgnEVX0RULsrw7zmearAUw+XslMLC+QTiA2O
	o60WRQj0rvP3SnpnYwb+u0ng7t7hYvWzxKPD/o+kBmTC/A9uTqERoqWqhXnaedWv
	r9vgws8gvjJ8fDVqkcyYlAdg/A57SaHbLAlitobIXU6jQwEubzovDYEb05eGTBg1
	XKEm3Pl1uSUQGtJva7dqwXd+D5syugIMtQrST3tvkxyZCeuNpB8e8r9W0q1neT6o
	4dsHbdp3vow2qJoGgko3MDouSocPSajvW7k5Lew6FoJOv5YYB3/JUviR9hkP39Ch
	IZhHMLFKeBKURT2hVkWgsxcq9/JHOBkgMRMcveJqouttlA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh31pw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:25:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f20addba1so603192485a.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794407123; x=1795011923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QHCjyWnjJaKib08TgPofPSfS5d3rT38/26nHs0v//to=;
        b=kq9kU//7jboNEnvjXnuek+EFFJRctr9eWXse+0lie/jvi3lGmHDE97Fbb7ROc5mcsp
         /qtZN8aMOphOwhrMM8tsNJ3FazK1KaE1AMjqXgz9CkdTLCpg7gNdJYxtpLyP2jBbRe/7
         843HDff6nn4WvxtQvXB4oXq7KEPjj+txTsWl2VrNKwydUS8zlOwtVEYYslQ8zxA58i6Y
         38fq5+7QfAI+sNAYv8VpJ+QQc+6fVGEprVX5mNv3OU5mU2wgbocniAX+XBn9o4oaRP6o
         boGOYuzIRPTuh76NIYaeTp5+HkluNbQXZAlf9VBYOrUv/E30FlaVTEzw6kWqzeBXDyuG
         IRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407123; x=1795011923;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHCjyWnjJaKib08TgPofPSfS5d3rT38/26nHs0v//to=;
        b=VormXhIeZgjI0H++9iCNxGNS0fzrKCpcf0hV2u74qPgvVeEg2rMO+kZjQcYTtsXLu+
         wlbGDjqByEh+7YgU2WXsUA9j7kqiXw8K5dsWlfoY/Dtuduz9nYUS00UxcavZYLf4BsdI
         heYLVI/a9M20KYKO9vOVUOKGuYsJwYaE9nzfzutAtHEJqh1hnClGOOPq0VchaxkBgHA0
         JoHP/KyMg2XkQ9VWDcMotNq/akAtyKYJ8BaRN0FJHileAWdkOxKbbKnjnwQ2kPjUXnOP
         Vj9xBIe6UywwhZvixonwHQQ7+ipTKcUnmhQ/BscjJj5o/EpB7WETYc1LCLDzlZe8FsVJ
         V3Bw==
X-Forwarded-Encrypted: i=1; AL+hErErJoaG7s+it8qngSn/k/kI6fpxBw/n6idi3hj7Z0LNQgkcdVl0KOg6RS5RlpsVzglt9VylMLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z83zIHYAfFBJE+FsBWgRR9sHUo1jT/Qf/Hv/foPh82LtFEgwTTo
	4wMtTO18yjhfsTN0lu+LG2uS3pyd2n2gzk0DKTb7oz4mVuTMtVc7GMjHQA/L+t9mjLuEhfSCXgD
	VMeQ2kvoI4ICxmTV9KLaAdVvIYoBN/Yw2XOQPdtZz5dcRrEJyvso7jKoCn+0=
X-Gm-Gg: AYBFou3NFao2DT9f/y6o7EH8u65+CYH5ucAjJZ6zlGsjC1UyIpTmMVD/bdecqdZ58q5
	XIjBcGWMnqwgi6a/n0xQhTLc1QuVzhQAeUxPhfGxAs7mz14g7HoYrGRcsYSSxi9pQWefs6jnkpc
	ppaQ+N0jhBL/QIecXCRYOn9qj9EZRMKEJnpX6QteB25LbPD7MWxM8om6ZcA4WBK+e9mWfNjKNy1
	ZZnuhTVwcnsHbHL1lnS2ghYeinS150S/CWXU05D4m5LeoUzl7IzWxMaMqaS9BUk2VRcQkgGFpCT
	AHAWs1LI50Q7EYK+kFwTYqy6ljumeVBdrAvuaC0FkqxQ7TBUrVpYUCYmVDYfyRvuIUZTyS1f+CA
	ZT+Jy0vwFlbhQr0Nyy7g2wdh6AqgsSkepDT0YK9ZaF3PoGsQgVC79C3wRAcZ+m4QVgjUB4ZJtuO
	ZskDWYN2MRaJMWhaFlgGxS1JJ3ttViqzFLOUmhIxQQuENIg/fr9iBz1461SmpnEQ==
X-Received: by 2002:a05:620a:4711:b0:93e:5daa:67a4 with SMTP id af79cd13be357-947afd6c994mr406653485a.29.1794407123535;
        Wed, 11 Nov 2026 06:25:23 -0800 (PST)
X-Received: by 2002:a05:620a:4711:b0:93e:5daa:67a4 with SMTP id af79cd13be357-947afd6c994mr406648785a.29.1794407123071;
        Wed, 11 Nov 2026 06:25:23 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c15bc4a69fsm552820e87.84.2026.11.11.06.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:25:22 -0800 (PST)
Date: Wed, 11 Nov 2026 16:25:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Joonhoe Kim <26rote@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v8 01/29] drm/msm/dp: skip sink requests while the
 mainlink clocks are off
Message-ID: <ldg46pmbkt2ntfpmhdgu7hq6va7ljck7o7pua6rkkkuij5b5c7@dqhf3ozkjoom>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-1-d040fb33db5f@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-msm-dp-mst-v8-1-d040fb33db5f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX3m/KOB7zS/Fn
 a2uQHbd8jw9Z4y5qc2iR+nWtFYzfycJogf2tiW9QPMKMhwiJVxtB2PO+4ijxxJvuIqATL17whkm
 yF/2mrA4/9pT+wqzNKufQoKeD326W4Q=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af47ad4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=_QjLU-fBZjFD5OgerkcA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: pOQnzirL9Y3utob_HWH8oyqdkWBvWtDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX0jqpe74huQPT
 3QoKNxjtwmf028y3JPlOZqillY+KopOQ5hfFro6E5+yXfs+6hMQlEHqm+ykY/7xp7qI/xACKZb8
 odOrFTqNB+R0/9GB5gytCsFk8Eq8nOQ0zxXUb5wWjUWx6Rh+Va+nA9Iu6+HWSDxzkl03S2reIr1
 399ceL102owc/iM2RT954eUaMGsc+Ij4QD9YObC/AgpwFasa3s8TiVT2qhUCWsbVL4syqJmBtWC
 Irh7zqs+MPftB8QJ2KBP/3e2ODuLenHd6P1HuPCUMYMLnMOqPj+oJizgeSvNF3RvdVN/DoxuYKT
 UYbvApSSrnuur3dU78MRyv2tCWMoCbPvEQOIzT19f+wknpiMzDe8qjluTE5HbGVu/g1P3X+GJPd
 hadGJzymgPqwZ2Sy3dnRod7bTOWSdv1LJwZOEypWeTaKLZh28ZuhvU8OY8SRqmrO5pM5GfthvxH
 n0HbtT8+Dm2QYO7rvJg==
X-Proofpoint-ORIG-GUID: pOQnzirL9Y3utob_HWH8oyqdkWBvWtDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110056

On Tue, Nov 10, 2026 at 12:54:22PM +0800, Yongxing Mou wrote:
> msm_dp_ctrl_handle_sink_request() programs REG_DP_STATE_CTRL from all
> three of its branches:
> 
>   DP_TEST_LINK_PHY_TEST_PATTERN -> msm_dp_ctrl_process_phy_test_request()
>                                    -> msm_dp_ctrl_off_link()
>   DP_LINK_STATUS_UPDATED        -> msm_dp_ctrl_link_maintenance()
>                                    -> msm_dp_ctrl_push_idle()
>   DP_TEST_LINK_TRAINING         -> msm_dp_ctrl_link_maintenance()
>                                    -> msm_dp_ctrl_push_idle()
> 
> That register lives in the mainlink clock domain, and nothing on the
> IRQ_HPD path guarantees those clocks are running. Disabling the
> boot-time mode for the first modeset from userspace turns the link
> clocks off. The sink answers the link going down with an IRQ_HPD
> carrying DP_LINK_STATUS_UPDATED (DPCD 0x204 = 0x80), and handling it
> walks straight into a write to an unclocked register block:
> 
>   [    4.572532] [drm:msm_dp_ctrl_off_link] disable
>   [    4.573756] [drm:msm_dp_ctrl_link_clk_disable] disabled link clocks
>   [    4.823194] [drm:msm_dp_link_process_request] sink request=0x80
>   [    4.823199] [drm:msm_dp_bridge_hpd_notify] 128
> 
> The board hung on 3 of 3 boots with a 5120x2160 SST sink attached over
> USB-C. On the hung boot captured with drm.debug=0x100 the printk ring
> ends at that last line, the drm_dbg_dp() immediately before
> msm_dp_ctrl_handle_sink_request(). In the RAM dumps CPU0 is still
> running pmic_glink_altmode_worker, holding the bridge chain mutex taken
> by drm_bridge_connector_hpd_notify(), and ctrl->link_clks_on is false.
> 
> Bail out when the mainlink clocks are off. All three branches need them
> running to do anything useful, so gating the function entry costs
> nothing: the first one resets the controller, which its own comment
> notes "will need DP link related clocks to be running", and the other
> two retrain the link.
> 
> Everything else reachable from the IRQ_HPD path - the MST ESI handling,
> msm_dp_display_process_hpd_high() and the video pattern test response -
> only talks to the sink over AUX and keeps working as before.
> 
> Reported-by: Joonhoe Kim <26rote@gmail.com>
> Closes: https://lore.kernel.org/all/20261108011501.4466-1-26rote@gmail.com/
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
