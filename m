Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739570;
	b=cs1VAZUp51Y03xhYrHHSfR755tzY/59PKma0i+1UCmOan00Y3MTqbEzNxLvrrbWXzTk9
	 AmCYGr9SkLnrOOb1gMhOTA7hxpcI2z1oJUfjZLlj/wd22Rbqhg6vilvbAfJ9c5PrOl+uK
	 0pa6SmbTFuxbxV1fk3u5LEqpAuz30Ap6SdBQubC7jg1j9pYlI7eJVlcfaONbabUCxasxr
	 fQLX64KhMql1/QMzexw5t97KfdsttOLQdPJvcour/jv8+voXakr9bKBq9PDj9V5vVkl+7
	 d7zKPBjh0PVk6U7PwOHBx9kcwm1gAn1/IvYjYgpkKlDxtTiVi+IZ4l01I65BVp+S/bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739570;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PW1CLbvqlr5fSy5oyi5HAW2alm1vh7L9g9nCvQTuD8M=;
	b=ulxaPSQOU8YsGUTvogT1GGzRU07mk3Xji1j0cZC/K+hWACsXG618mwmFICpjbdp02CSy
	 t4CMbS5+2gqDbO4C5kbr8464n+mQH89DXLshdHyO/dODh8P83R7hixDq7qzcL/RE7ADdD
	 z+TSJP4vL9tQXikg4hQ8TQbzrIhBdPANnaLjdbZ0on9amg8QL94/Qjv0BevSJ10p8b6Nr
	 8maVxe9xjJvi3aHTJVT0u3MqXnzGdthxDbehiQH0mrHvveV8Uveg9Sem2fUEoWLaPqgHT
	 XNNnHEa/7sim/9605JxdhW9U4j4Eqj3WfmEgLSEtT9Y7dfNxABUqh4Jval8Qnf68lQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P2iEYOho;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hjbB4m8Z;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70251606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70251606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P2iEYOho;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hjbB4m8Z
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF7wqW03778864
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PW1CLbvqlr5fSy5oyi5HAW2alm1vh7L9g9nCvQTuD8M=; b=P2iEYOhoA2tNINKg
	8aTX61BSPTfyw+BiPDwHp0nP625gvjraAsP5qviHMpoWdIHYKZXV639cIqyZuZO5
	ZK3dllqGC1MGzubpk2iysopC1rAISiYobRF+GgU2PbzFVW6NCC9U4K0IshcFvazo
	ms1LYgSQzTsmImLt/SJBlRnYlKPwAhtz5RGoHkdzoj9aTcyLZ0hHHNrOqLqSMcT2
	5eph79ffTwrKqXGSAs4TIcmShiY5F6qK8zEFVu/NYBmgAK1zPR9kJvhgq8pTvvAl
	uNYzPUaY55h37+edRzbQxvc/bQB5EA1vge7RK0FQs+/fRYkyode2X1LwywKGXZsq
	xnoyow==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8tpq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:46:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f559420f3so257576385a.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794739567; x=1795344367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PW1CLbvqlr5fSy5oyi5HAW2alm1vh7L9g9nCvQTuD8M=;
        b=hjbB4m8ZtsUhHX3BAU08P5bccBpSjaJ7KBCuA08ijOudcWvZoqdLCZ6J8Pg20PsvZJ
         VoVW/lNMXC53rlfVFUISij9W/svKs5qPHTvnJ18ApGw4+pyJ2KyJ0tEqHywX1mrnF9R/
         UlJXLYNgxn/FcGOlK9dSSWXL5l6315z6TkNPhKeCXVy7I3cyJVD+hRLEvZupP/5NYZg3
         pI43Fj6uel1geFcgaRM8Zkm3iv9j0Ztd3BtVAGXcBiaQWqp2lplMENXcHEVQaSkg4lck
         JrE2m+46dJEZVuPDlqUB4ENdU30zeNBecSm56oroBDnJ8iqCzM1TJZzUjduzIjxoWC/A
         i7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794739567; x=1795344367;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW1CLbvqlr5fSy5oyi5HAW2alm1vh7L9g9nCvQTuD8M=;
        b=Cg4/FbmD258dXBDeqH3DJFbudwNfPcCGpUoLzVEeEJK8pJImBeFd6Vt4SI2qTnz3Io
         fNAEkCihGvidPOasvDi7vNUaMXd+PgnHCZUubz9gOkoU2VYYl1A0onDKt4djRTYTc3KF
         kDVqP4w4pNelQEwL5Tx9akBiBDgsjSCSoyP0d3jt7V8555cm2F17gKPUGAsCS0EBfFmm
         /SZy8P9yjaefj4u7Vi1VTdE/Kl8sQrCLrxpibIEUcErOJHEyTlvEuHaSuBs2SNYbMg4p
         DOGHdGqwpJI3PvL5meQel50O321YMBGquoVZnbHKJzCcrPL2kDi9DAON2CyLhd+NcV4Q
         BLOQ==
X-Forwarded-Encrypted: i=1; AL+hErEwMu2o37IakPFBGK8mbppLhqD9Jfw/RYepdD89eX5zA/a2UZwyi+cCzfPffqqREspadhzoAsk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8L3Pw1a6F94zX/3O1M6O+AYRXWZG8xw6kiVBsbXtHunQfOKbe/
	nmQe8H7MuFP95R2HzKHSYbzzGettlQ4+oSAqKbXz0v4v53DN5ydDJrZqn9kxrlc+nNKpgcNYzUR
	LT+BGS8Nn7zPI3ydiQLBXAYTgJg1BtMm8v7N2ZMpMNWNfxgLpz31suLVnP92nbIXOknM=
X-Gm-Gg: AYBFou2RSJA64SsxEJllIQJ8zbng7z9lktebHnpZ5YvpTsy8PwldpKifwQSbbMefQhm
	We8YAlZFlpBfA38gSRIsXx9W7zBcJFrZVndq5Roj3MvWvXTWCLsWuVEhP3NxuaqhTrGJ3Qbb18Z
	QeCFRwzQtgVXtYjsnV5DzzsmvaEn9LAp+YlAtiV+lms8/NRU2qhQJA2bPSohJfmDPflHhAHXG6s
	vpkIcSRLYhVsBK4WbAFJyLWzGOBLMWRU3xv36BawO9lEv+Lc8Q4MW16L294PUv4Rt/OzhfMZxK/
	T7nQvUKe/7Mk8lfQB8q/gcU7jlwP5edyGeCiBOwxUAwwLmRYC03tgbbhtidO7/VtkBhh2TEO0Ac
	knef/yfZoZ56r0hWR/BtbVAZEtRJ+tpV9tnIWcS5K+FdAt5ilSG/dxfpy1B7kqwLImSrEZZowgF
	Tawy9BdkC0L6e8IgzceA==
X-Received: by 2002:a05:620a:1a09:b0:948:e2fb:c00a with SMTP id af79cd13be357-9494bb892fbmr1229212585a.28.1794739567476;
        Sun, 15 Nov 2026 02:46:07 -0800 (PST)
X-Received: by 2002:a05:620a:1a09:b0:948:e2fb:c00a with SMTP id af79cd13be357-9494bb892fbmr1229210985a.28.1794739566963;
        Sun, 15 Nov 2026 02:46:06 -0800 (PST)
Received: from [172.20.10.5] (82-132-234-47.dab.02.net. [82.132.234.47])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b1b5asm3069071a12.4.2026.11.15.02.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 02:46:05 -0800 (PST)
Message-ID: <f172af7b-f5a1-4375-a62f-6e389b1a2508@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:46:02 +0000
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
Subject: Re: [PATCH] ASoC: qcom: audioreach: apply volume changes to a running
 graph
To: marcht@proton.me, Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111-q6apm-vol-live-v1-1-be85eef649c1@proton.me>
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111-q6apm-vol-live-v1-1-be85eef649c1@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6af98d70 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=AI3hfGQ59aOwaD8qyfpUrw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=fBJCkzpva8F84h5TpLsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0MiBTYWx0ZWRfX0LduGlHpHzqN
 OWhJx+8Fnbw3MQbqOIqEcnsGH4mBKmfLxIvmdtH0p9T5timmn9np6ydV/OdlmsiM+Lt3f40Dzol
 lL9zq7Rz7njU++3hk8D0+P3xakBJfJA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0MiBTYWx0ZWRfX6C8RK9ZQkpxO
 zy7l6zo4LMu0Kf+A5CrtOtHRhNmy5ZXAmSP3G+JghIClsGdRGlhyYKUwlSwhm6TTHoOUcjdS+rD
 ENn8vSJ1Wk7RDQngmq62ZDkFsjvE0/DF1xZCE4Zg2XK+6SypKsiBS/20hceXyQCqPHT2yvj9R1V
 HroNG3SlvGnEwivRDdic1u0W5KJ6+oUjIv/7wvbfNovrdauwlOSja8cXHQ1GrkGNy8Zm9lZdWZM
 3yO49+bEEtv7f+lcM2JpPQBAu+hgdN2vPlmZItfsnyP+J6qWm/cIWCjMO8ojUetv3ZgFbWiSV1q
 De4E3JAReZTmFSvwexItpwMrtArE9BEBD4jc5kL5Y4Ef6MeHm1c3tZSfw7kmvUg4glbV5k+msgO
 s84q8yl4nXr0h1wRkG/kirUZbfxHq8xMHwS9eW6pxdrD3Chib4tlJyKXfdDR7n5rKBrr2S5s6a1
 dEWYQVvlMUqBqkItRXg==
X-Proofpoint-ORIG-GUID: NJgusTcZI5PFRRhWRUoq7MB8Z656Tb0b
X-Proofpoint-GUID: NJgusTcZI5PFRRhWRUoq7MB8Z656Tb0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611150042

On 11/11/26 1:49 PM, Marc Herrero via B4 Relay wrote:
> From: Marc Herrero <marcht@proton.me>
> 
> audioreach_put_vol_ctrl_audio_mixer() only stores the new gain in the
> module. The gain reaches the DSP from audioreach_pga_event() on
> SND_SOC_DAPM_POST_PMU, that is when a stream starts, so changing the
> "<stream> Playback Volume" control while playing has no effect until the
> next stream.
> 
> On QCS6490 (Radxa Dragon Q6A) shairport-sync uses this control as its
> hardware volume: the volume set when an AirPlay session starts is
> applied, but every later change from the phone is ignored.
> 
> Send the gain to the DSP right away when the widget is powered, and
> report no change when the value is the same.
> 
> Fixes: 36ad9bf1d93d ("ASoC: qdsp6: audioreach: add topology support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Herrero <marcht@proton.me>
> ---
> Found on the Radxa Dragon Q6A together with the two fixes in
> "[PATCH 0/2] ASoC: qcom: audioreach: fix S24_LE playback and route mixer
> disconnects", sent earlier today. This one is independent of them.
> 
> Tested on 7.2.9: with the patch, moving the AirPlay volume while
> playing changes the output immediately; without it nothing changes
> until the next stream. Builds on asoc/for-next.
> ---
>  sound/soc/qcom/qdsp6/topology.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
> index 612d8f03e6e9..5b3378fd29fc 100644
> --- a/sound/soc/qcom/qdsp6/topology.c
> +++ b/sound/soc/qcom/qdsp6/topology.c
> @@ -1323,8 +1323,19 @@ static int audioreach_put_vol_ctrl_audio_mixer(struct snd_kcontrol *kcontrol,
>  {
>  	struct snd_soc_dapm_widget *dw = snd_soc_dapm_kcontrol_to_widget(kcontrol);
>  	struct audioreach_module *mod = dw->dobj.private;
> +	long gain = ucontrol->value.integer.value[0];
>  
> -	mod->gain = ucontrol->value.integer.value[0];

We should make sure that the graph is started before applying this, if
not you would get dsp errors.

--srini
> +	if (mod->gain == gain)
> +		return 0;
> +
> +	mod->gain = gain;
> +
> +	/* The PGA event only applies the gain when the widget powers up */
> +	if (dw->power) {
> +		struct snd_soc_component *c = snd_soc_dapm_to_component(dw->dapm);
> +
> +		audioreach_gain_set_vol_ctrl(dev_get_drvdata(c->dev), mod, gain);
> +	}
>  
>  	return 1;
>  }
> 
> ---
> base-commit: cde5523c75f1320a55ac1d55a717ccbb566557f0
> change-id: 20261111-q6apm-vol-live-d6bb1dbec7c9
> 
> Best regards,

