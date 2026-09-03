Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADA4A49BF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439276; cv=none; b=SN8V/nM89200bcAYcoTaAownbnf5CvwLyQXHZri60X8MSFvHQ4SZgZuW3QUJhNRwoMzUFfEyatTUVaRYxC9KBR70+a1CvvFvJZe9nY1jahVrAKHf+3CN+Hymup9urg9Yj7+W8gFvpW1su92PQ6Q61NRooO/a4WrRzIOtCkqSe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439276; c=relaxed/simple;
	bh=HKrP6WAuuGCRGxPtoZXgzlZWh7Uw52p6gH1hsBJAHoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjeMo98ahsUty/ftgTH3PmONufrjiGtvmXL8t/Ozwp13TSmynVyJBB1j6Ul2sL6DjTMhfltvXMzVSG/ghro9NmUXMXF8G/Pp5VDZHlc/L3lfbYNEqkY3hApDutfccS1HA128ceq5zn2Qkq1GjVyKqEWpVSr94r8Mv7hc03EWGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4843e397f74so1392866f8f.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 05:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439273; x=1789044073;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3HqcQ/B1fblnEsvTxBEQ1Ob0X5CAkA/L1H0oy4/vp0=;
        b=VkHf31Ri6zXPJJK+sX6RkhyRGWMA0MYo2kHutHq3yqCtXvDs1x9bjbeKGO2+45nCP3
         LYuBFRdqBY/whcB2YANhto4QJI8tKQXVCIEzY4y58xOdaOaOaIy0hoVP7Gqb751BXz81
         El2JlE5PZY2KwwkZrTgOE1LCc9fMuBlt3++6D6srBZLnZ/q1dYJII5F3/XpLwT8d1pHx
         PrZGHvrhVd5dUGs+SYoPpei4rAlbVvvBSLDdCn+B9GcDyjU+gxXzYrwweLijuRv6zo6e
         BwgUh2UDwOkuTAY5tqGm4kmkokl6i3+8AEYgRQe9xoFvJjfs0nLUep1lJfA90Lfl0mys
         ZnVg==
X-Forwarded-Encrypted: i=1; AKwUvBxwTuuW8wK/LQZRSacqjfnFfcGfwYpBjheRwTOr3GJMZcbEzsGVzw8pu7TS2qu+sSdkEIpyTjk=@vger.kernel.org
X-Gm-Message-State: AFuF++kariuAZhsJIdMZ53tVs0xcbAU+3aOt0q3v1byt5RJc2MNFkdfy
	aSNJKDGw4FoRLSAd4TlVrKyoQj/i8l0tPj2E0qEMSiguJ7em9CnPS+PU
X-Gm-Gg: AYBFou3lxoZbGdWpXuXnErW+h/WsLzkx3tINCzwdiwEAkTbIEA6yhTSyNwIlN5QhwQj
	T/BNupEtn53B8AkPLCyiIpAQt4nNV37LSpsU3jSuNraYuemIFh2piuElTr9ljcQbbGUggHcIusL
	Te37uS07Euazv2UbIEgwPMrVuZXzwrn95kAwEagqHyNUClfl254mpPx3H9uJT9rwXwXch6ZiaE1
	xc8nPzCfJL8RtMQaYlXxziDXBIOcpEwYPpzVr3LjrcGlGgYMwAcZgdwusYXE0HeBLU/Ubcrk7vL
	fz6o0fOzqbEGJ1mdoONx1CPrkuFaPThEW+huX3DNYsbIo3qhwjtV9+zUaerA3h/dYR2UQt4r+PP
	twsPXAvPiljC133i//xAjf2vzvsHVTAGPoGNAGtKCLbXo4fqde9hwSgFx9Pbms4HuZ6Bom8QdAI
	cfZQJtDKj6YIQaV5mvMgOovHrraEX7oEMMLGGVQ3Ls4RwHt2VbzncNGT0brZBdTeAQHo2WbKnm9
	m3E9wr9QJtXiQ==
X-Received: by 2002:a05:6000:25fb:b0:485:8226:c699 with SMTP id ffacd0b85a97d-4858226c9a7mr4439744f8f.24.1788439272910;
        Thu, 03 Sep 2026 05:41:12 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea96csm11530590f8f.29.2026.09.03.05.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 05:41:12 -0700 (PDT)
Message-ID: <7b69c767-764b-4701-9523-9c49016a783f@ovn.org>
Date: Thu, 3 Sep 2026 14:41:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] openvswitch: fix wrong flag value in
 get_ipv6_ext_hdrs()
To: Eelco Chaudron <echaudro@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, aconole@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, cpp.code.lv@gmail.com,
 stable@vger.kernel.org
References: <d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <d42d6f04596dacab6cabfb1f06aaf4bd53394d3d.1788423539.git.echaudro@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 10:18 AM, Eelco Chaudron wrote:
> The ESP and AH cases in get_ipv6_ext_hdrs() used IPPROTO_FRAGMENT
> instead of OFPIEH12_FRAG when checking for out-of-order extension
> headers, causing the fragment header to not be recognised as a valid
> predecessor.
> 
> Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")

Cc: stable@vger.kernel.org

> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
