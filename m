Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836850;
	b=GvWbwvDc93eYrh9e3ma6kGdfNyOvj1qOGhsBsjCEe2todlcFhqOvGXv87cfYK4GeyF+F
	 202eAvYwhhqwMn1E6Z80zCv8WGwTXKHR/k/ogvVnfHqHxCLfd+HVS1sQeEkJ8N0R+U9sC
	 dsDP7UokOXykANy3dxiEiJqNOAi5fnsE+VkLwHnWMwc/bUj/PYIjJw9ub4qao1qvuxcQC
	 UJEt+KSB21Vmu10tN9YnRkOWmIWdls/dDAF4VZLETt1+OV3t7rN8h27aPptKaROwMqhRG
	 V7ka6fq2XcnQ+TWmkyAAPuCSv7DICreWkiiTXCSM3t9aeo/3kEJdN1Wcv5ccdVV5Z0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836850;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6RqHZbkC5y/QxLCiE1SY6DQeARDF7gzlTK5ApO3Srk4=;
	b=ArEpl5jkPlH3+TqIaE55jLmKGdqig7P5n9kfJetHdzc7MLeh05vRPp1B5j0THUnquIc7
	 Hg5KCuj3lAZy5chVYYVYntBtp7RL1kQOXe3k//jRZsrJoJxPVw4Wai9oQN7jASnt5Idei
	 YqTETvh4TpayjHU+zN6NiDuW7upL9o7Sw3Oph/6A+/CYjBWWGZMzqbUhI3LnixiX74+OE
	 6oCwp4CiBwf90cS6K1aBb9GxGM7+hWef4j7+3VdNAA2sYTiAYPArYmlsEqTPMhPXyEJ13
	 5EJQXXPsrgwuWjCfnmYWTkHeFd1+a9tizlCt/nya+EiwbTPDDQeetAI2T/YbZJ6WhhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VulwCmkC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C00F7606A31B;
	Thu,  5 Nov 2026 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VulwCmkC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BBE761F000C1;
	Thu,  5 Nov 2026 00:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836849;
	bh=6RqHZbkC5y/QxLCiE1SY6DQeARDF7gzlTK5ApO3Srk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VulwCmkC2ZvoZK+EPYfny5vmPTPHvIgT7Jck6gNtnyMJg95J1JW4w2TWZffqzMbJu
	 98+1rtt5QKcgOvIt7lw1WBxaDolomHjf3vNYLkwtVWiApZJfSgYLi/Z4kECZok4vQ6
	 p9AYsnpBHEobuC9G/vTQEDebXN4d06NuAHY6CiOihRMMvycJ89oECXrzMOCfJBYZMn
	 lccPv+EtCeIkCA/QHgPOLHkXYqezM7YlHmcDMXVGfw1WZC+5Dnyg5jhh2To9xT3jFW
	 i3Yy5MUXxeWiB3ZoOkOUGap4t/+3hh/PLPsu12gBcgykes9mUbTUE+6t3MZU+wwmoc
	 FOn1tAozI1F7g==
Date: Thu, 5 Nov 2026 02:00:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: eventlog: check the payload size before reading
 tag events
Message-ID: <auvHLaltiRzE6eXl@kernel.org>
References: <ausQu4DY8WARe_2j@kernel.org>
 <20261104112613.58589-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261104112613.58589-1-zhugl3@xiaopeng.com>

On Wed, Nov 04, 2026 at 07:26:13PM +0800, Guanglei Zhu wrote:
> ...

For me this looks decent. Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
