Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F2296BCB;
	Thu, 30 Jul 2026 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372740; cv=none; b=H2bbU4Gr28QR7kvPNV4rS7qDBCoM5HfZz2zdiMFqD8/jSLIqlw9oOckEJom/ssQ36Nc2kBwhnRBi0msmBgVXxokdY8j8E3hpAvg8YkqvH0tFR9iQU5ugJY9ddmuOJIjEPQ/CVGWth11qi2gyuwNwFhjSwF32ar8Ttcnjd9rneT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372740; c=relaxed/simple;
	bh=andyPO+Fa6EAKjjMMCAkCOwK/lBkwyOJ0JqLxudyy70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwU0o2eRdRMYpG3gba17Wf0WJamQcfDRZmSS66uNupIXB9K10WGhbLvzSY3cuExq0YmybAxibBDFhfvHsWS9ZvKwg+flbUQizJI0W6invrA7jBm9QusM1ZaKdnZzCyuSWlLjNbs8YgefnZvWn+yq+lpuRpR2yvwB2+SEqgnc+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUMpuqIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUMpuqIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5C11F000E9;
	Thu, 30 Jul 2026 00:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785372739;
	bh=A8ArPrcD0I7gZYVXMqisP+tuWtK2GOivpVVbvNKuYik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mUMpuqIE7t9QhnpclHSOSOGXhk3OBAm9nNUHDMfY56+UcGeRD2Rdp0nLmdjc4ytPc
	 wLewGNIYt0wIVb1WFW0yNmyfBQlCWSFcEhTKCAlgkCA/eY/jhYz9IXlj7qWhjnMdfM
	 PdtcIrlkG4wrrDiOZY5XDJUUaxA0rHhLcAJHQmQVtMi84UWjijbZCbFX6da+rpJG+W
	 JPsgETZYZdFgfqNOL4VP/fdcrMfavSwPf/PjW2muE5cSJq6xfAQK7wONHQTqjuvTn3
	 i/TKMxxaLSOEDJB1KLcVRuGqbZSNYhB1R5G5BAon1NzVuiwMi+2K2hX7p1sFTJD+EV
	 y27XB+vvVS7tA==
Date: Wed, 29 Jul 2026 17:52:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
 linux-usb@vger.kernel.org, jarod@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] usbnet: cap max_mtu for drivers without bind
 callback
Message-ID: <20260729175218.15b5d081@kernel.org>
In-Reply-To: <20260727072304.154608-1-lvivier@redhat.com>
References: <20260727072304.154608-1-lvivier@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 09:23:04 +0200 Laurent Vivier wrote:
> -		if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
> -		    net->max_mtu > (dev->hard_mtu - net->hard_header_len))
> +		if (dev->driver_info->flags & FLAG_NOMAXMTU)
> +			net->max_mtu = ETH_MAX_MTU;
> +		else
>  			net->max_mtu = dev->hard_mtu - net->hard_header_len;

Sashikos point out that this will causes issues for existing drivers in
both directions. Some drivers explicitly set max_mtu. So we need to move
the

	net->max_mtu = ETH_MAX_MTU;

line before the call to ->bind ?
-- 
pw-bot: cr
