Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928310;
	b=xUuqRT8VH+uePjpQxSZzAnHbU4x7PM5bDgo2f5KsmQ3ve8+SQOip09DKLLX3JRGul9nE
	 Edr4FGC/mtC59Nfn7gg4O/CK1kLziPfC1QroWa2hBuqpNybrBhmfp3uVcF47uEH5UUq/u
	 VUKck4dFlNc75Cuj0q8NWQkAShs2dVLJFWlU1drLlw8h+i6IsvOmWHZ065gRNKGrshZQ4
	 dm58ISjvFQjoy/Zhfeb0+QnsTtgihDJSZZp8m8vDKqGmBs4MoRPo3YPQY5/4c18Av8Llw
	 hoDZZmoXKqE1Nkb2aQtdjaKNS9dL5WeNKMlw/3ntsOr/PvefUtMXn12oKWLfUaYHbEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928310;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pNzD8Dd/4XFbhGgAaIYAJ585xLYgQxuD6+8BDcYXRhU=;
	b=pgX5LIlKeN4B2fYl5r2/ocIXcCZfG2oWtyIigHdWLGQT2LR1FAqOQVS0+1ik3DqppywA
	 rl1HnUgNp6TCjUO5iK93DKa5avtNmAdHps0dZohQx1UELr0HlzSiCN9nh1YWY9F3nrsGg
	 dNNRSyETVBkv0dyEjueeNlu1T6RAun1Tr7Rpg5z3/Vy6r9so745SJanZZ9hkTnnQwLlvK
	 pl1XyGSupvPd2zHiWhoIfGeJN2ivZiV6gZAPhtFy/VPt8QWkKaG6qovEbSIufuLlpFeyX
	 XCmIS9qlAfSE1P6taPClmTAFn/hZ78mmGtky1qgth7v9NUGKHaLnn6YedpsmNbWhuXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LvjYZQit;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DXxXuRNC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB774606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB774606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LvjYZQit;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DXxXuRNC
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC180f3713845
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pNzD8Dd/4XFbhGgAaIYAJ585xLYgQxuD6+8BDcYXRhU=; b=LvjYZQitAUsfFsf4
	fAtooDTrDGJioWzyr2+fA+DwOxZeBWz6+E4OJ6x9/LRON/pluJAvOFyxGAwjFh30
	SHYozf3+bysDM66WyZUlPrES2tT8wnhFCOp1qL2mXiuNjl+s3GMbLTk1bxKvevgs
	vh3dNzp06WZlL+tbl9eo2H5nW+i2/K+dW9aNsuMheN6muoVzVzmxABSU1E498QV2
	2XFVkGvxICXWI8d3dNkhXhwFiQnxKCM7rf+jwa2BZytLFsrHn3JBcQRDJRcFWs2C
	3p1cK8P8Y+x3RakH8WWiqYbOGCFO9Fz1NwjEK++Xe7ll9HH9cgAhSy0wFfEiS4ia
	wgrcUA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve237d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:11:48 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ec62c05c25so673357e0c.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794928308; x=1795533108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pNzD8Dd/4XFbhGgAaIYAJ585xLYgQxuD6+8BDcYXRhU=;
        b=DXxXuRNC3FB7NY9JAvfO0kBGEr+rLwhtxvW3XPRvKXcHHmx53Cp7PrakZM0uKPeuIc
         GyaRJ9MBKFmEnr9fro21kXpTE21Ls16VQhOtTNtP4AdN0mjQeLn9PdK8CXz6mQGldJp9
         8C1Lpa/12tVO58wmxHuEZmfusquzyWqShs7Wzk8jOzdSmS8Zdm4LhOcpJbSUg2GongbN
         r/vXuqCfVZv5OG9cKxWXVPlHKav2vj/jnO7aAqGPNShv7V/hRNgWxORwXSgHQecepjY/
         qxOqEHpLMAKb+7XDuGLVzmEHRTzZq+Z8YPWIOzL9ldpwdVqvu1NgWIYfuddxx4Vn8EGH
         umaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794928308; x=1795533108;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pNzD8Dd/4XFbhGgAaIYAJ585xLYgQxuD6+8BDcYXRhU=;
        b=pIl2kJ4ijJFbfo/GY5rIjXMCjKzih8a7UqeDuoNimhsR4yxd0h6olIH1Xrdj5sQUC3
         AcHM0Foa9ESJgFtV8d+PF/SmLHSbJcu34us+zgJRJaZKfRvCfhLU/UBusXRq5lHjiK4b
         qvLBPNKLXgook8s2Gkt4n3FB4kufD8zszIghTPD16fOZCdAydFy+wELRweNHjds3mGJh
         8Yegld3oeeEQQ2uIdnSGA/jFM7zduqK2nFjVknsvil+qu6BDWwnnVWQMY5y48X6ccp5t
         0uYMIhxbyngaJ1N/r3Vihx0ONek5Z0jad3Ue2eI2Du5FWTcnErnY+ZZyDB1S6hnZ5nHE
         l0ag==
X-Forwarded-Encrypted: i=1; AL+hErEAyp2hubRvo47A9PoZgS+YKBW2ijYS1NomJaWZUbNzo25oLG2dvQ6mymuQj12oESRBwBNuuvw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GP2ZUnXVljRQkswEnXvowGbfj5BnKrDp9+LqImYZYa6+ioEg2
	MdZ1/rnOcwPdmP+dPbs2iQ0xrUlvTIE+bIfWPgPy6v1ryL7WbElj4A1GhkGQr/8SgL3gdzLe/ns
	qTbNa7x14V0vZa7PRloOyTflfiftkUQbslHZNbgKO8TfAXHY4GObiaZgXPoI=
X-Gm-Gg: AYBFou2JYHyY0LqgMIXdfmUlr7/mpLPLPqFYD6rW1y63DCFfKbJFFJVq7jGeis+w/c9
	OG3nnR+OHNg0KYPheT0qXbIzoZgEFV/MiWImIzoJ1YywwDi6NfPkv6goPmSaggdGAhbQYWxFS/o
	EGZT8qA9wu+65iNYWN/iMqoThUYEyEblhfvFWdC9cet5smDRJtanKOGrPZ+2iIlIdTglilLuxvs
	BlfD8+x6hOpkxKXsCBlGhT8rKyi2pcizPIQtjJqb+KHTXG9623Q73MboiKdwGJsVuVCe1xq5TkS
	X9Jh7g0DDYBkUK2s8kDx6JepZzxmr2pNQcRXNFR80Ojuu3yBYDnxeS7m+b1qAXUXvwr0zgTLMPf
	JzjXaFZZP1+wcfAWdT155/7SYaKTlfskxd8vOTkZWdB1kyTKp4527IO36uaJJ9lOXV5NXmfNfYa
	w=
X-Received: by 2002:a05:6123:404a:b0:5ee:b3:a43d with SMTP id 71dfb90a1353d-5ee5b8023acmr633962e0c.21.1794928307576;
        Tue, 17 Nov 2026 07:11:47 -0800 (PST)
X-Received: by 2002:a05:6123:404a:b0:5ee:b3:a43d with SMTP id 71dfb90a1353d-5ee5b8023acmr633917e0c.21.1794928306764;
        Tue, 17 Nov 2026 07:11:46 -0800 (PST)
Received: from [172.20.2.50] ([195.50.164.66])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5c171264f64sm4169498e87.0.2026.11.17.07.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 07:11:45 -0800 (PST)
Message-ID: <23d3e257-284f-484e-b7e1-b597208b8fe6@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 15:11:44 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: qcom: audioreach: only disconnect the route
 a mixer control owns
To: marcht@proton.me, Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261116-q6apm-fixes-v2-0-ea89fb43316a@proton.me>
 <20261116-q6apm-fixes-v2-2-ea89fb43316a@proton.me>
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261116-q6apm-fixes-v2-2-ea89fb43316a@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MCBTYWx0ZWRfX/Va/1C0iodrO
 zgamsC1y7VBQy9xFBTPS8BIJD41acrNgTNlB6u+BiJQrUzrQB6+M+taf8fl8XCqkDOQeSb66aze
 0JLrDCiKZ6zO1OUeP/7PNkbcK2AGbkw=
X-Proofpoint-GUID: X9u5ycEZn2ZAZivqIRVuluE6U-FTg2ok
X-Proofpoint-ORIG-GUID: X9u5ycEZn2ZAZivqIRVuluE6U-FTg2ok
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc6eb4 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JUj6TmFbuaZIJ1gx_BAA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MCBTYWx0ZWRfX0QF4jZJ4+5pr
 61pHIORYYRn6CJadJIiqRxymb69KV1MDK/6kFJRmoOlJ2KOc3MXqwjfh6Ey9I4O9I9FoMW14tQK
 UTQTbtZSW/9xAZKYR8ttodiycVlncet2VZnvOAYhvvSKW1qLrcc/s7XgbPlFaiye4OoCqbEN7Zb
 rHUe4K/hjZ6SaZiomb1AlM5EiAnyIg+bZxCZtGKbE8am3W2aOyjMagy/HT7Edf9GImq3kOBFJ75
 OXDF0b1X/uVJYY6HwJ8qOM2PC4BcSz6d+F35c36gYwydT1W5dIKRaop6e0dMic6Suqta1Ylo4Bd
 8JZqCbZcjPNCVu9qe0kvpao8a88TZMfPC3JWfAuAeF3qWNsPQRd+N6rh37TvVrS1EwDyI9tLkmD
 Gl3OmhQhLATTMPaVxxJiwwJIF2wpRN3AsvodJV1dR+CguxOoy1ZMNG3SqR9d6FuMpiwtiQsqEpH
 lpkdQ5nDpz7wRjz/2Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170060

On 11/16/26 8:16 PM, Marc Herrero via B4 Relay wrote:
> From: Marc Herrero <marcht@proton.me>
> 
> Each AudioReach virtual mixer route control ("<BE> Audio Mixer <FE>")
> connects a front-end stream graph to a back-end device graph by storing
> the source module in the device graph's audioreach_graph_info. Writing 0
> to any of these controls clears that link unconditionally, even when the
> device graph is connected to a different front end.
> 
> When two front ends can feed the same back end the result therefore
> depends on write order. On QCS6490 (Radxa Dragon Q6A):
> 
>  - alsactl restore writes 'DISPLAY_PORT_RX_0 Audio Mixer MultiMedia2' = 1
>    and then 'DISPLAY_PORT_RX_0 Audio Mixer MultiMedia1' = 0, which leaves
>    DisplayPort disconnected although the saved state has it connected;
>  - the UCM HDMI enable sequence writes
>    'RX_CODEC_DMA_RX_0 Audio Mixer MultiMedia2' = 0, which disconnects
>    MultiMedia1 from the headphones. A PCM started on MultiMedia1 after
>    that never advances (hw_ptr stays at 0).
> 
> Make audioreach_connect_sub_graphs() only clear the link when it belongs
> to the control being cleared, using the same test as
> audioreach_is_vmixer_connected() does for get(). The DAPM mixer state is
> still updated for every write, so DAPM keeps tracking each route control
> as before.
> 
> Fixes: e4977b91cff8 ("ASoC: qdsp6: audioreach: Simplify handing FE and BE graph connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Herrero <marcht@proton.me>
> ---

lgtm

Reviewed-by: Srinivas Kandagatla<srinivas.kandagatla@oss.qualcomm.com>

--Srini
>  sound/soc/qcom/qdsp6/topology.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
> index 612d8f03e6e9..aa2ab2b058d0 100644
> --- a/sound/soc/qcom/qdsp6/topology.c
> +++ b/sound/soc/qcom/qdsp6/topology.c
> @@ -1240,7 +1240,9 @@ static void audioreach_connect_sub_graphs(struct q6apm *apm,
>  		info->dst_mod_inst_id = m2->module_instance_id;
>  		info->dst_mod_ip_port_id = 2;
>  
> -	} else {
> +	} else if (info->src_mod_inst_id == m1->module_instance_id &&
> +		   info->dst_mod_inst_id == m2->module_instance_id) {
> +		/* only drop the link this control made, not another FE's */
>  		info->src_mod_inst_id = 0;
>  		info->src_mod_op_port_id = 0;
>  		info->dst_mod_inst_id = 0;
> 

