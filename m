Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359433624CF
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199144; cv=none; b=LY7TLR8xkkdVHJ0QOgBoHhZ8h7GJQG5Yd5/IwahnkDj7dL3/NUlPPvnFKuG3jN1PaD3Gz1IM0ZSpuMv5W23WJd6d/wxMlb7P4tJP5CKwCZII6ObuTnBptnW7iae7Y/HEZJCsOSgwSSmp0ZQNhn6ESsDxMjl8tj6s1oCHP6XWeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199144; c=relaxed/simple;
	bh=fMvS95Zokxhi4YAY/DKRZh4u0zJjTtwNe/Ad1WemONA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzmPPhFANUrmK2yQ3ztsic3ghuEscBtx0i4Yuc/VK4/Ho+hHFh1wHMxNaRc0aSicCMppy9IrtE7SnEp247Wd5mAe530Ntzqz0rD1xPXR0HpWW3FALgV2oRF8CI2EdP3/Y2i30NonrxmJsj8dx/4W1b0i0+SjIw3JKW7ROhG/Yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFtXxhmG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFtXxhmG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e04df8c46so4081317b3a.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788199142; x=1788803942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ZgJ5g0NbcsQZow9nFskcMFtht0b6aFS+BcFnkpsMUc=;
        b=fFtXxhmGbnlogy0zGaOAsEU8RfCdLAm2l2jewh7ubAP+7+Lhwf+jZd/2qaDwzMJuvp
         6py6zEpPGn5jHIQJC+ExeWJxVnYJXVqPqBeNPUiBRA2EIswzT3FFKSB0qs1d2Bdu5Gjv
         c/F6rvdOxg4ob6anZSk2GY637/KtOPuV9nDyMObDbM6WBnwQL6YNyQuk6U2MT+SWpakl
         bhFcqAkopJkaYKgXs5r2T1SWy5Exxi3MGrUmv8iyApO+nCJqgk9SG/9JBnGt9KPJzNkS
         bpDt585NE9AYOxsuQkfCW0gOXQCnB8t7Vhl8ABX4f4q/R+3/6h/HYi3giC+AxqDYMho/
         GUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199142; x=1788803942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2ZgJ5g0NbcsQZow9nFskcMFtht0b6aFS+BcFnkpsMUc=;
        b=kWfcDoTUhDWshqsA1cjUJZFAjAkhy5/4aUx/j89HfV5ZDIc+LvQrahFuLsFrn8dE33
         G8nyczCDEcNIXR7Fmfx4e0lnXZANetAa7zWsQpB1Y7fW/RGH6eWP8reSvlD69JxiLhG0
         Bd2OPCYag2yVQx5lwDBsHc0J22Rd8uU16sLHp6RElvaHQicOW4btQxerNvOrXOEvq79X
         fJTcfCfLirUwR2+GVHHDRgnLtxj8L0zaA14Yk1OmuSeoulhiA6Dns+sM8/LXzmoGKXt3
         vwVQOk12gfgALQ0OTL9FBfSabXvkw+HicY9Uqa58gv2is0Uzw30jYyNrtzEMbTFSWyRH
         ROrw==
X-Forwarded-Encrypted: i=1; AHgh+RpIBNT8ywI3y+JyrUWd13snPNGHbCvANzwzihrDZ4OAttb3ZjHB47Dz0D0ctxR8wYFyRswCYRU=@vger.kernel.org
X-Gm-Message-State: AFuF++m+l9nJzSEeBaVWlooz6Ok6tOynnwiFEtmbHcIY5ycnYs+5qPqe
	52ML0WfYPgm7dnWGUTqbUOk2Il/iF8l9M5URtjqpv9h68OIXpTKhRXqX
X-Gm-Gg: AR+sD12NJCcDtzOidGWSwqDntVeV0cYxGZL8DiYqmR3GKtdBhec+ZgddgUs3CTyl0g4
	mRrtZRvobRTw1MO0tJLLE5zLSDNR8DaU8r6/fRG84IJrI6QfKgSRjBxUYs0YABh7UaI5VsCW78Q
	ktNWoSVb2er2sE/QX/MF067xIQ4u+g/zGFd3ulbBK7WFbr7CV4wDIhawrDAstjyCN5DeOSsJiay
	kI/4C+P1rKZIXTHrkCNfJevCbsv4C1VB5g7Xmo3FAieWwABFAsQKILq/WD9WCo5SsNMShYXdXAj
	UEsimAs1PqjknvujZDR37c/poXQ7PCUEBgmPZSsqaoPuEQfx8ITHTtQgFuW+qkZQCOfXpUACYJn
	SzsWOSUoQpOsqNxIQomOtxngZzhQWxjDCf/514TYsH2thHencSMH4PO+BxQWsarn73z1kgHVMmA
	p8/u0ftTnwun7Qdn92PBrCSlOAGMV53GoG7Kt57y4Swq4Vm/6if5OVNIPxiTtWuhloscaZCr919
	uYtM9pOjJyKD1l1zWRp1YlUMHgwVPCUXSj3gZCI8nOxTqZsdzec9vOFqUVxgSX7n69V
X-Received: by 2002:a05:6a21:498a:b0:3d3:ae50:97cd with SMTP id adf61e73a8af0-3d3ae5099c5mr26881038637.26.1788199142325;
        Mon, 31 Aug 2026 10:59:02 -0700 (PDT)
Received: from archlinux ([2405:201:1b:20ef:268a:fa82:9f05:61a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa37fa5sm34701575eec.29.2026.08.31.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:59:01 -0700 (PDT)
Date: Mon, 31 Aug 2026 23:28:57 +0530
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Arda =?utf-8?B?RG/En3U=?= Ari <arfeliousheres@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-wmi: Fix board_params typo for 8DD6
 board
Message-ID: <apW_MbaycTf33RWu@archlinux>
References: <20260827235139.154462-1-arfeliousheres@gmail.com>
 <apKKuL5lh2OK-6lq@archlinux>
 <8cc78401-cc88-3136-5d72-eaab779a8690@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cc78401-cc88-3136-5d72-eaab779a8690@linux.intel.com>

On Mon, Aug 31, 2026 at 07:38:40PM +0300, Ilpo Järvinen wrote:
>On Sat, 29 Aug 2026, Krishna Chomal wrote:
>
>> On Fri, Aug 28, 2026 at 02:51:39AM +0300, Arda Doğu Ari wrote:
>> > When adding support for board 8DD6, &omen_v1_no_ec_thermal_params
>> > was passed as driver_data instead of &omen_v1_no_ec_board_params.
>>
>> Hi,
>>
>> When I added support for 8DD6 [1] &omen_v1_no_ec_thermal_params was
>> indeed the correct quirk. But because Radhey Kalra's board-specific
>> feature data patch [2] was accepted first, my patch probably lead to a
>> merge conflict that had to be resolved manually, which is why this is
>> subtle bug got introduced in the first place.
>
>It's my fault for not catching it (though to my defence, I got sick around
>the time the merge window ends so I had less time for handling the patches
>in the first place and I only now realize compiler won't catch this
>problem for me because the old structs are still there).

No problem, take care.

>> > Because active_board_params expects a pointer to struct
>> > hp_wmi_board_params, dereferencing active_board_params->thermal_profile
>> > results in a type confusion bug and invalid memory access. Update the entry
>> > to point to omen_v1_no_ec_board_params.
>>
>> Thank you very much for observing and sending a patch for the same.
>
>I've queued the patch to the review-ilpo-fixes branch already. If Krishna
>wants to give a reviewed-by tag, I can still add that to the commit.

Reviewed-by: Krishna Chomal <krishna.chomal108@gmail.com>

>-- 
> i.
>
>> [1]:
>> https://lore.kernel.org/platform-driver-x86/20260623141314.33947-1-krishna.chomal108@gmail.com
>> [2]:
>> https://lore.kernel.org/platform-driver-x86/20260615091034.987029-1-radheykalra901@gmail.com
>>
>> > Fixes: a7320d6eb9c42 ("platform/x86: hp-wmi: Add support for OMEN MAX
>> > 16-ak0xxx (8DD6)")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Arda Doğu Ari <arfeliousheres@gmail.com>
>> > ---
>> > drivers/platform/x86/hp/hp-wmi.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/platform/x86/hp/hp-wmi.c
>> > b/drivers/platform/x86/hp/hp-wmi.c
>> > index b2773fc1aca4..615b4cf6fc45 100644
>> > --- a/drivers/platform/x86/hp/hp-wmi.c
>> > +++ b/drivers/platform/x86/hp/hp-wmi.c
>> > @@ -337,7 +337,7 @@ static const struct dmi_system_id
>> > hp_wmi_feature_boards[] __initconst = {
>> > 	},
>> > 	{
>> > 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
>> > -		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
>> > +		.driver_data = (void *)&omen_v1_no_ec_board_params,
>> > 	},
>> > 	{
>> > 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
>> > --
>> > 2.55.0
>> >
>>

