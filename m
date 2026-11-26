Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712052;
	b=cb3perBb3iSZUgrXEDb8/Z/C13x8qrLDIVxmHgx0d+kB+I5pNShXB2u8o3qIjJYGdt0r
	 LGRf2aQU95NH5E0VrY6wR0mAxRoMd0pFZ0BbpVuaVKf/Ns5Mw4sf70ge5UWQFotEPntCE
	 +CN81YAPmZ+D5rw8+J3Bb80/varkDWzlGaOZoNJUV1SPjQgIvJW0134vwN7Xc904m9LGW
	 jgEkwl41P1Z03rHzJOFCcnriJQEEzlB/QL577vZmF2jAD/8mxIgnwoug34huIWyN0u/0z
	 Vh3kCGnPbb906aIGvVWamCDphh9VF4oJfPLiX6lTX8NxEnBS7JYz/8gOJ4UIOWBs2vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712052;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=BgD6gycym5GNErjaqgDBYiiur1kGK45lPA0q9r032kw=;
	b=mxI8cUEZcY3lcq8nOzlle5VCIlVoBI30J1s96MsdRGGXzG82YwPT85tz8tcsUnig2Pvp
	 GIssjXM8Mz1vvSMLkCA8nDRhAEWqfJB2I3UsWjzrnR7vyGgiwPweCUlwrCjF0ynIvhgGh
	 viLIQlNKdy8GGZEcIPJDWqsxvVGaRZN06BVjL+m6adOQiRxfG+Tq+tOVymHco90M8Xb7i
	 rb4gOlh4LtIPr7hLKiSLxzEecTGGnIDcbrcqVlJBsf5s8cTSQCSl2tFTAhO501sBT0/uO
	 Fi37bThH2Pe+Z9c8guQHGhXXHui1+/px0lxH0jWQ+B1WCDaLFFYjFGWtigdnpRa79nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fI9nOEaN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F681606A31C;
	Thu, 26 Nov 2026 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fI9nOEaN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C73C1F000D2;
	Thu, 26 Nov 2026 16:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795712051;
	bh=BgD6gycym5GNErjaqgDBYiiur1kGK45lPA0q9r032kw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fI9nOEaNlS20t7eTH8sFwAR13GfwJzalpfGgoDlM5kKS8ZC3RdhgGYqNa4qdUzI1D
	 l7LfMQnECL3A83wPQNzkt6YgRBAxcaBWlOvFicmw/Tk7dAZLjoVusE7cR/G6eCZSlD
	 D+UYh/Mbob0buqz1Te/DHOLkho60WkJB+shsvAGepuR2U7lxHSzwYGvvAzdyqDxMLL
	 KWXLeXZjVazu2KkQ85FyPeA0LTj84s/q7StqKLpviiDk0AiHUf72dFIw1aOz1aVH40
	 +pxTiOKk4BCOvWxK+NW9J2Yoto8R2VuwdtHo/ZPvlrqtl5fhC3jjTqTLjmMZwmfbnM
	 erRAxkF5tq6Gg==
From: Lee Jones <lee@kernel.org>
To: Lukas Timmermann <linux@timmermann.space>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Siqi Chen <chensiqi@uniontech.com>
Cc: Griffin Kroah-Hartman <griffin@kroah.com>, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261117083917.3304865-1-chensiqi@uniontech.com>
References: <20261117083917.3304865-1-chensiqi@uniontech.com>
Subject: Re: (subset) [PATCH] leds: as3668: Propagate chip ID read errors
Message-Id: <179571205013.7277.3536851788674532345.b4-ty@b4>
Date: Thu, 26 Nov 2026 16:54:10 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 17 Nov 2026 16:39:17 +0800, Siqi Chen wrote:
> i2c_smbus_read_byte_data() returns a negative error code on failure.
> Storing the result in a u8 truncates that error and causes probe to
> report a bogus chip ID and return -ENODEV.
> 
> Store the result in an int and propagate read failures before checking
> the chip ID.
> 
> [...]

Applied, thanks!

[1/1] leds: as3668: Propagate chip ID read errors
      commit: aa2874292fb936d16a4b6b1c3ffb0555e6f354b6

--
Lee Jones [李琼斯]

