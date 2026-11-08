Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165958;
	b=er7E7cWuermHTNbrz63fj2sm2KYOyd5BKtlOC4E2FRo9Iv1x+uLTZAe9NbW6lRn0O9+8
	 gR620a85PYTJ4uDCeqBumtr0nx6fyP2+yccjMEMdRcY0bHlkEJhsMqI5MBCeFxQzMCeqd
	 AvM9Vp5EugETd0FyXXanwq6NKADrhFbnN9v3zjOn+EA7d9HVZgldBNAB2MVoCBqvjINSa
	 qUH1eBoxKZRLmOJCr6Gze89O4OQ9SA/Zjpfb9mUmqn2f3VKNr9dZx2MUcJvI3Z6d35fuC
	 DhUe0n4W0qrNQyZGGPu9B/Wgfrh2Ld9PfNxUPcAzXpeQVI4G6Om+Ordlh69zw4AYdOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165958;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rvz+8jpHONGozfnXzrVmPZPB8+T67M6uMGo0MVWwUsE=;
	b=p92FQ7g4tr1HPRkrEu4HL1qwRQzrr4jIZ7ICs0lxcmflrZOc021CilpAuxliBLJtnTYI
	 loxmcKIa8llvtUWcb8L+4hBqwItNs0sgY/frnKA6nJ/tKfZPlSqcrbrPIbuK/jwhDZsGy
	 M4fYZbWay7oA3B7MHoN+4opd/KrchEiJYii+trKy9KzxIa/uouVuGqc7fgGKMFNgnUd3f
	 bimkQ55Mrbo5v+MHM3+synsyMZVIWDHG+FLJF+TVBKBe28p/xfEFGY9l/HJudny+/3QH1
	 lzAxhU4LFIDwEaNZEZc6dV7Fe6EKK9GGsSLwsXARVn9CMgf10am2A1xGLwrx/uHKbgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ugl5bvoO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IbXBwigL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8A606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 19:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C8A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ugl5bvoO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IbXBwigL
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8HoXSS3145294
	for <stable@vger.kernel.org>; Sun, 8 Nov 2026 19:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rvz+8jpHONGozfnXzrVmPZPB
	8+T67M6uMGo0MVWwUsE=; b=Ugl5bvoOuwlQXxrUrA71wfKTtmkNLftBCbXUUuAN
	QZ3eC1llxn8rk8MMN98SNoAZu90W38y6VxqbDnqJooqrVKkZ+SxXMvbsTAA3xK82
	QNk3kmY0knaQozYbR2bUA8Cdb0rZnRhfOtSkmTdj+MyTcBs8EGMjSy6vAJ1/I2Zo
	Vi4KUFXj7UeiJ99TpJZ94B15gNiH9zYKh4cfF4NcOIGuD7hJU43LeP8l11+MhMBD
	vBEpjU5CIDq8PbnKmcZprcQP1M+KK1E0Hp/1+wAbOgVRVK2E3PxpcKPimE8JlSCv
	Bm7PHEuJa0WzkR5qe2O7OPYecH9ZzSVq3zXrU/7ERlcDFg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hstxsbp9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 08 Nov 2026 19:25:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1f2fafeaso29206085a.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 11:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794165956; x=1794770756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rvz+8jpHONGozfnXzrVmPZPB8+T67M6uMGo0MVWwUsE=;
        b=IbXBwigLQFsMVyPnDmNgfEB2SlT4wW7jKxbodQ1Jf8vVZmIYt8kScPFakVBWUhWGDj
         eadh2zrD+G061KpWDLP52MZjUkYzwRbZ5x1fXAAozjGsTwdse9oWfwLyxnSYQXA4Bqzx
         dOkviwSamVbbC8cVVvP2iQpiVm8vLy/HpD5pjWEwpL64xOGsi1v0TdfpWBDOaQo92/IL
         trEcdDhyJsmgrRF4C+t7/cMdYmGfKV2j8EDHBXB70dmRCBq3aN5y0x7XZ6YOvZGsDLz1
         ZVjIwVEi+b25TNcHvXwDuf+pNg8wKKHN9vPjC2GE0WtR3ZZvyrqmWt/9109nXRgqxwof
         g/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794165956; x=1794770756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvz+8jpHONGozfnXzrVmPZPB8+T67M6uMGo0MVWwUsE=;
        b=UK07teSICdelruKmKgmuFoX0kAHHClw9Zozx1jhAenZykT26Bdyl+q0IBij0VGQ9SH
         BBXqJ5vYJhMve19ON/gVDsY4Nb/p3jCj4UBfV8ZbQaIzFHeYqZfoZjD3PIIBuO2uVhwt
         JW/HFH6wg5H3CrY9ZhVvUnrFeBJXsU70hv+/dwgNxXQw/ftAVqchBu6iap3sObhCJX/3
         nS/wzkwsH//MvSOKBPWvjPzkSpd2pKj0tth+J5r5QJSeSCn1tzHUycravo3QH3Xf/5ON
         YuE0PeNeWsrLE1O9+PnIQ35NBT+ImrDjZCJzqH+hWyTZvwlRLI3azmhX5AT2/6eKpKBV
         +DLA==
X-Forwarded-Encrypted: i=1; AL+hErHJam2nNVY6azXEYy/A+qe0ZELQSndXIj5dR9L5vebZ1xjuTZ6YpqFkibs0HlqjeaGpw4xQwxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tp1VverQP4kJ1/qqcL2oSfo4TGy0IXvx/pf4HTU97nRrGcgvz
	MSnXxnkzXzIai+qJLvxdp49tcpEdqL62rWPb216DlP23wXPXZ21sGffRCGf8NW1XyJI7iusLxVo
	SbKiLyEUIbS9LD5CeqSAynkEaqmM/bUZBsy035erq02MwjOkH8BtqyBXpJsA=
X-Gm-Gg: AYBFou1LmwtLVUo6f0HaEIuiUhWdhAwnkiQ/ryPfFhnBdHIRg4IQRzqF0sPSjM5HPS6
	WI7YDlP7RFlNcz15Pwh9Uc6G1dgJE543+gp8hpL450KKfo2Ptq4nRlE+i1AJBVxAiy2KBb1uLnC
	EU9zKTBjMlFsVuyIIlk1gC+fHzgTsJu74f752PEe12jXK223xhY1P7ou1QmzOxptYNeS6ZAbDuE
	eAGFY7o6Fz95kMOtbgre+Qmpbs/tzoJ/U+TApcuICBL8nOaox5OYO+R5IGBA+gCZzHgrNCCZvKc
	DWu2NhYuzjgDoPM5TuuHRcnAyUr9uhipJyTJPu5mre0vphEyJe6S/UWjM2JsFABQGeZsPa1QKJl
	3VGs6fehbZENN/oAWfTsLwZmyAM7Zrw8S3g2WEKULokzgR+nSoeeaOwtXnJHKyF1hl+TcDFPJNe
	8H8qYIM+RFf6uaHxrSzIL0XX/u0zKVT2aPHrem4rAe+DMt8Xk7N1fW+pgOOrzR
X-Received: by 2002:a05:620a:4804:b0:944:907:8f64 with SMTP id af79cd13be357-947842b26e8mr289432485a.67.1794165955761;
        Sun, 08 Nov 2026 11:25:55 -0800 (PST)
X-Received: by 2002:a05:620a:4804:b0:944:907:8f64 with SMTP id af79cd13be357-947842b26e8mr289430085a.67.1794165955285;
        Sun, 08 Nov 2026 11:25:55 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b81c9d2sm461073e87.68.2026.11.08.11.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:25:52 -0800 (PST)
Date: Sun, 8 Nov 2026 21:25:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Robert Meijers <linux@robert.meijers.dev>
Cc: yongxing.mou@oss.qualcomm.com, abhinav.kumar@linux.dev, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumag@kernel.org,
        marijn.suijten@somainline.org, quic_abhinavk@quicinc.com,
        robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
        stable@vger.kernel.org
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
Message-ID: <vr7xot6mfkdjou3wy2ni33ctban7goaqsr3xuw73przuefaupp@6lexppuvjypx>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
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
In-Reply-To: <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
X-Proofpoint-ORIG-GUID: UT7ivEYzT_68BSG-RcBeqYmJfQ8EWMR8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA3NyBTYWx0ZWRfX7LuX/vieBuJL
 0W5r0JP6+ZJvxxQrJbAtWJGKpoeBLkXaMMHMv45wWEHiMlfPjXJpVNv/KnkrH15G318WXZIRCUi
 N4o9HPmD96+4OkyED6wxIJzvAIenqrI=
X-Authority-Analysis: v=2.4 cv=dZMVTnXe c=1 sm=1 tr=0 ts=6af0ccc4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=ne830HvUTAimPEXBk1gA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA3NyBTYWx0ZWRfX7d5iVIOndx7C
 CxJ7i6VZnNX5773+Hk1eNmzstt5+S3mOBdNp26HkAt58itW34D8RRsy1lcSihp9OpP+GvC/MoHM
 bxjfeEHGFMB13V82av8whk6W9PPwQd2UnJ6LS3+BkV1aFA21CUxunGkuA1cfkUlVo2+fGn/5cGE
 v06eTqTMNDUuuvOeaxe0H0a951GIv/i7C2xYTuGwiYDB58q1CxN658RV37Xr6ii5Jjix8r/K8G8
 KMwR0vTw+SiA49q8P8lstu2NvoOa+I8SdUa3iMPs/6R0my8teLiZVr0GHom997CxiMn7AOzTvj8
 ERkd53WpHVB2mvx6iMH9UCrjgK6Ev5eCTwB1/O6woeV8d0pmTejBSdcf69A1gWoL8C7CDcVvpo2
 PyR1/GSclG5VFB+yTFdJvdfUsozNmlvXourhZRP1HDk1qSevO8Xw7KctCnoZfCDeL3o+wvnFB38
 3rfUTP2B7fN7n9GzWnA==
X-Proofpoint-GUID: UT7ivEYzT_68BSG-RcBeqYmJfQ8EWMR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080077

On Tue, Oct 27, 2026 at 10:04:54PM +0100, Robert Meijers wrote:
> Hi,
> 
> ((Sorry, re-sending because the first was rejected for not being plain
> text))
> (First up this is the first time I'm participating on a mailing list,
> so sorry in advance if I'm doing something wrong).
> 
> > Add support for Multi-stream transport for MSM chipsets that allow > a
> > single instance of DP controller to send multiple streams. > >
> This series has been validated on sa8775p ride platform using multiple > MST
> dongles and also daisy chain method on both DP0 and DP1 upto 1080P. > > With
> 4x4K monitors, due to lack of layer mixers that combination will > not >
> work but this can be supported as well after some rework on the DPU > side.
> > > In addition, SST was re-validated with all these changes to ensure >
> there > were no regressions.
> I have applied this patch series onto a near mainline 7.3 tree for the
> Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches
> applied I don't have working audio, over USB-C to my (DisplayPort)
> monitor, anymore. If I disable MST support on the monitor audio works
> again. Debugging (using AI) reveals that the DP0 Jack is not reported as
> connected anymore when connected to the monitor, with these patches
> applied and MST enabled on the monitor. As shown, for example, by
> amixer:
> 
> $ amixer -c 0 contents | grep -i -A8 -B3 -E 'hdmi|displayport|jack'
> numid=208,iface=CARD,name='DP0 Jack'
> ; type=BOOLEAN,access=r-------,values=1
> : values=off
> 
> With MST on the monitor disabled this outputs "values=on". The same is
> also reflected by "pactl list cards" and "pactl list sinks" where
> HDMI/DisplayPort is reported as "not available" with MST enabled (and
> "available" when disabling MST).
> 
> (Again, suggested by AI) I also checked the ELD, which in both
> cases (MST on and off on the monitor) is identical, including audio
> information (like "speakers [0x1] FL/FR"). (Also, audio works both using
> an AMD and an Intel based laptop, in which case I can also choose
> whether to use "HDMI" or "HDMI 2" to switch audio output between two
> monitors, in daisy chain).
> 
> So my foremost question is: should audio be supported in case of MST,
> after applying these patches? Or is this possibly out of scope?

I'd say, it was out of scope for now.

> For clarity I would also like to note that without these patches
> applied audio over DP does work as well, irrespective of MST being
> on or off on the monitor (obviously always running as SST because of
> missing kernel support). Which would make me believe that no audio
> support in the same setup might be considered a regression?

Technically you are right, it is a regression in your case.

Yongxing, how difficult would it be to support audio over the MST?

> 
> Note that I do understand that me running a forked kernel on a
> (by upstream) unsupported device might also lead to issues or require
> changes for the fork. And that if audio does work with MST then this is
> something the maintainers of the fork should, most likely, fix. But
> from the cover letter and commit messages it is unclear to me whether
> audio support should work and/or has been tested when MST is in use.
> 
> Kind regards,
> Robert
> 

-- 
With best wishes
Dmitry
