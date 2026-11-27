Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798960;
	b=2XIXoGUG/7oUass0KbiNITtN6PkHlQHnUhxLED0eKW7SOhjbHyAyRlb02I4PYB8t9kxb
	 OvfYQoJu3j+2WJTV0WJm+tX0Rgr23C+LbVkqz9O+2DNQuJTF9YnabpOcAK63cfTz2Vyx6
	 71EJkA2X79AFGh/HxUfbTKiEjJC67OC0Y/nUMew/gYY5xMhAUIoJ/hNjmKQ04voLN4Vwx
	 9VIYzRykOg0VQyFWiXTQELXy2weArQ1Yem4B52rX5auKa/UEZ3EyOx+VtZS/NjqKIShGF
	 O3g//WqAg2r3FhxogiQAsRB07QTndgKgf56VnlFZ1i1V3Lkj3PsWtmx+5Il5Sgr7o6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FahanQDAZkqt2MsuInHmie88fnw/2xHMMbBNAexzPvs=;
	b=lN87sG/L4Cq4End+pm5W4q3knnLX8SzeYVS8XtI49aOwQLi2eJbiCAAjBZHefK4mSarF
	 U7qRWF1QuU/o4ysV1qQT10Odz6AgTutTzbz4jJHspuYeONyKsTLJZ6fDYkrd2Itg3f8Gv
	 uZqMa6eCsqdhX5ltCGnktk1jlHTQfXNxY7FrpZFKafpI89epgZWt35nvgGJtHcHRr5zD1
	 5MuoXv58J5dI+cjW4pVXOZ4J5m2v6S+8CJ2YtjCg5xQ6OPLDw/MycUUJvSDSDI6+qI48V
	 8JKf9yHzi+VPviBYiVILcQoZiXU8BzzZzbDQZtG2Xv/mmkb/0vftnTz6y6SR/La+SCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCIxLGpd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE51606A324;
	Fri, 27 Nov 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCIxLGpd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770AB1F00919;
	Fri, 27 Nov 2026 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798960;
	bh=FahanQDAZkqt2MsuInHmie88fnw/2xHMMbBNAexzPvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JCIxLGpdOVKVW0mK37JgGA4qQpD0jA8xnviCuGDTpRC+SXWF/enjhExFyCo6kqN15
	 x5wWtCs867f4A5YDLw9+xPJ+veBYrusQs7n0qiUBIbI4eo6UEy/LrJdPTAKyyLyzqx
	 +aRprm5XAko8ifqkeJBWaqSaF6D3LARkAJEQoWzmxXCsUlMqUFtJ+lM7c0hJ97vM3W
	 UhPXWzMXP0zgUGuaWOZAWQpCc+nDmuR2kuESdF4En3WqwZhQD74G7ucwiBx8EBfeMD
	 JBni/6jSrHUhGTgkpqzgY7/OnxXD4XBk3H2P5XWErmaRSLgOdbZZzwZo/ejq7HKBt0
	 1cBpystd2zTPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Salman Alghamdi <me@cipherat.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	linux-staging@lists.linux.dev,
	Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>,
	Dickson Wu <dickson.wu@certik.com>
Subject: Re: [PATCH 6.1.y] staging: rtl8723bs: rtw_mlme: add bounds checks before ie_length subtraction
Date: Fri, 27 Nov 2026 12:01:26 -0500
Message-ID: <2026-11-26-1-daily-reply-0038@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126-so3-rtl-61-v1-1-96e1a9756c6d@certik.com>
References: <20261126-so3-rtl-61-v1-1-96e1a9756c6d@certik.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Add guards to ensure ie_length is large enough before subtracting
> fixed IE offsets to prevent unsigned integer underflow.

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
