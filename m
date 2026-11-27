Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811638;
	b=0LozSBt3BggmVhYfed++wHfFBo9PqeDcp7iL5r3C8PVasN2RefOM5aIUhHN80fuAIxbd
	 Eeu2ER1TFIfG+iahcXhv8MIEasTJfLm1SY0bR8Qe99qEdfNX2aCowav2cdCI08YyCeR0m
	 HxMcvnpKhzlC2aMUz+HlcBD7OLuRVZxrqpLN+PyL8CFqD+UUGvJ5vu93+/Paan859v9q1
	 BN0YBZXaur8vzHuSNhkb4yTMqqhnucDbo4dxJVYbKCL/VjkF9Jqtny9NL3tNKxZhCk+3k
	 ImDz9nXLkmot5l6WN2rw+bPFQf6rGvknxa5HNlJwxDpnEFOgvj7zOPn8jHZ2z82WCIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811638;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8Ng8kzlg69sRcsx+ZMO/r1ZkmImQQcBdoWty1VqyZQk=;
	b=zX0SEvC8mwITQO+KHMpOgWPPF3Jd6WZVraGvczu+Z9Yl7X3Vkizv/UyjefInDg8Hc2d6
	 fn4LgrN7fi4e2oNZQEFa+XApSaoKRrJDsZI5UevfpOrh2RidVjxiwyy1zsNlObs7KN3jv
	 bMx+5/I4TYhVGvXMBB/rDa3xMNWemlooNrKm6tYHxV65+nTISMNAH3s+hnkHIWW17wr1G
	 SD5UtDm4X69XNKmBHnXscAY+/WdvTdc686yAeShpKNj+MIjWkimEXDXfCrFR1pjA1st4P
	 oOQdddevxtj/LLcJOLivgmVYT0enpsES3cmR/P5dt1soSCemuqVrlOgRP69DkqmTzZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AMsCzYt0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E2606A31E;
	Fri, 27 Nov 2026 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AMsCzYt0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68A51F0093A;
	Fri, 27 Nov 2026 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795811638;
	bh=8Ng8kzlg69sRcsx+ZMO/r1ZkmImQQcBdoWty1VqyZQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AMsCzYt0Q8v5kIv0CwijUSXN8EF4AXPeOMfnALA0YtLvoQez7mYAtrY3eA2Z9SWe8
	 DqqnjogtSTCdnKmM4mYtMn7EmWXU4huH/HBI8AGPyGv+Fh1uguLkst8sIyZ60VsIkY
	 HmdIrSC838d8Y+YUqIRkbRLnZIXK/HINJYzzYMpU=
Date: Fri, 27 Nov 2026 21:33:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kristian Otnes (kotnes)" <kotnes@cisco.com>
Cc: "brgl@kernel.org" <brgl@kernel.org>,
	"bibby.hsieh@mediatek.com" <bibby.hsieh@mediatek.com>,
	"das@emlogic.no" <das@emlogic.no>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"srini@kernel.org" <srini@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] eeprom: at24: wait for write cycle before releasing
 runtime PM
Message-ID: <2026112740-jackal-unchanged-f21c@gregkh>
References: <PH0PR11MB5807A1944E52A7E9DA0732E8C8412@PH0PR11MB5807.namprd11.prod.outlook.com>
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
In-Reply-To: <PH0PR11MB5807A1944E52A7E9DA0732E8C8412@PH0PR11MB5807.namprd11.prod.outlook.com>

On Fri, Nov 27, 2026 at 02:21:26PM +0000, Kristian Otnes (kotnes) wrote:
> This is ONLY a check for a detail on this patch, in case it has not been considered. It is not intended as a vote against the patcha

There is no context here :(
