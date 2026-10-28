Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187458;
	b=avFxPCI+uep4WfDti9f9hUog51BPYpappjFVEQt5gWsY5SBq9AjnUItLLYrpUzyH1XWj
	 YtAKkZWSbbYbe0EnEjsOeQNdQjfMnatdyLAUHD1dEaAqQBcA7dzwdVJ+6F9TsA6XtDNzy
	 LMy262fMWvRkTJekvSK89jUHBNaqjkZtP5j4ZElrlhuY8pDPoEL6efxDmCx94JcSFmO5A
	 If0SfBY57Yx1nncVuKYxoRzn4OhdBlWo6OORctT+GgwpGO0S9fyStcTn1YMLAwhaLaQzR
	 5KVVg17Lpwb9S+QinjYntoJPqKcRW8JHKGl7sBg3ECJQ4rw3Aztao1UudsGc6DEsI8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187458;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+4jHFx3O9fWiRtIyp5JwbIP86Ff5Ciz5ndhf0n1cHo0=;
	b=jw4KHr2PObdCl2LCM2lIPR5DhXrQbanrCLMBBQQ36eY/nikraKlsGNHPnhBzy/G6M/G3
	 u+C9wEErKrKj/GPEy6OoTj9SdgAKIW0za5xvZlLm5m2WF4UkVK3NUiLsmR36e8NImVW1L
	 kXSkY4IhGlWsLTRe+3Vr8qwJ5mzsDZVuGgoIDfnpgfMDmnND5Q/nSRHrjBFrFSp9phvWB
	 rksACeDcCHsHXpWexEo/sBWm4zpKN6Tn2pfhGQ5AUd4UNZWA2UEc6Htx3j1YrAVEc/dna
	 Pth8CAyI8QzhTheFIBuRKKGkMs+zFU7R2UK3rfflda6bKjUHQu85F+8GkawZKm6TdZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ZxcX8BCh;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B36606A31E;
	Wed, 28 Oct 2026 11:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B36606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ZxcX8BCh
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C89B34F1;
	Wed, 28 Oct 2026 12:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793187323;
	bh=GB91168LCZmaWnYiq32LOE2qoHE3HPCLJzO9vx24/FM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZxcX8BChleYWGT5kbn28zJVL2pWq+SQUsFD60c7Zh3qCDGbQ59FCAH+nP6Kr3UzSA
	 6ROQiv2si2OT9hjRmxaXvmJSn75oYsPgYXZ3x+sUfdHro2SifbSimWJWznAiyJYWi+
	 oGyXeX3lgy3tKPTueb5T5wK97kVwrOTHp15kOrF8=
Message-ID: <59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com>
Date: Wed, 28 Oct 2026 13:37:32 +0200
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
Subject: Re: [PATCH] drm/tidss: Fix serial clock reference leak in
 tidss_oldi_init()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, jyri.sarha@iki.fi,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 stable@vger.kernel.org
References: <20260916182950.2092071-1-vulab@iscas.ac.cn>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260916182950.2092071-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 16/09/2026 21:29, Wentao Liang wrote:
> The reference to the OLDI serial clock taken with
> of_clk_get_by_name() is kept in the OLDI bridge structure for the
> whole driver lifetime but is never released; neither the bridge
> destruction nor tidss_oldi_deinit() drop it.  Release it when the
> bridge is unregistered.
> 
> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/tidss/tidss_oldi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 17c535bfa057..bd151c83555d 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -450,6 +450,7 @@ void tidss_oldi_deinit(struct tidss_device *tidss)
>   	for (int i = 0; i < tidss->num_oldis; i++) {
>   		if (tidss->oldis[i]) {
>   			drm_bridge_remove(&tidss->oldis[i]->bridge);
> +			clk_put(tidss->oldis[i]->serial);
>   			tidss->is_ext_vp_clk[tidss->oldis[i]->parent_vp] = false;
>   			tidss->oldis[i] = NULL;
>   		}

I think this still leaks, if the oldi init for a second OLDI fails, in 
which case tidss_oldi_deinit() is not called.

It's probably best to use devm version for the clk.

  Tomi

