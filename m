Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798950;
	b=LYBVxn/6OoaSyabAb+2EfRTSGjDi2AVswAKxQlb/bP0PeZqSXQT74LiITQ4GEyETwcLD
	 iOhFMJqvr3Yen+VX4Pfwhm5RhLX5XVhTL9soXqHmzufE4Wd2MGV4QUnzGlcIdfw6UFfc1
	 SYlz6CCx7Mm4lEJgwIrd56yPvcRc4UpgB4runlbP1GhFKE7S/0FteO+21yj6jVvNlrB1F
	 PF5XxPzWbKvK1x1ad9F+g1rO7cjbbZcyF4PcYmRjwdtVgZMVrc9U76bgLHVc007wsz3s9
	 fZIM7wrsXUOqtNAiLHy34O3NkaraWJoeJ/r7Yq7fiK7djupsIbSA8xoeSGd/PnWFomA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MItBzeR58gdaRoJTgSk5xvX5+61+BKCEM6+/lc+Brqs=;
	b=alAT5y6IV6i8iW4XDLJbTt4B/OALF402dnTsnToD7Jnfda3tsgWFqdaJfDo50NfFHNOO
	 NgV1C7H6BYHBfsydQ8RrxN+kdmaclsdUkkoVSeY5/qvOAA3w7XGFgYUZojN5yAODgP1EE
	 YVA/Yk4dxVTlFUmyh1+Z1gQ1J9VJlsFx/25QotcJKRVBWdk/cnDYpgXWl9TIz3TmNXFv/
	 QEVdjGmaILgNXBCiKan5TIpny3Y8g0I09HoiqUN6aTjWoUc/FOgdqsrvLqkhmIj9Mo3ub
	 OrO+SnCgo8Zq+uAqAibVw6N8hwTGiQACP/9oNMitkBGL8pE42y8pJ+qewNXIet+K5tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEjeqL5k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92165606A32D;
	Fri, 27 Nov 2026 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEjeqL5k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3891F00930;
	Fri, 27 Nov 2026 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798950;
	bh=MItBzeR58gdaRoJTgSk5xvX5+61+BKCEM6+/lc+Brqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEjeqL5knTmDwgLXq1PFSYutBjLAuxEEypzM8pHtIHVdKFYeXTaK+qMi9V9MVSLBB
	 PNnXNITDkN9njKUDjwaHGj0guXB7OA9Pj2/GC4mSTITpmcnIktdM6bIVKy8oARMx4Z
	 hXgkLoIhRBmcEQeZg12UuoAfRWBguyKlm7QRrx1ZW4Ic3JEJUBEatVixp+wggDY+f1
	 3lai8bHqGhk6Bl59fe378RY8UKKAcoQUh7ZRhNL0ULVMUoT/dpHMyzl9uD3/shrU3N
	 Mj6hsH69ODkz0masY/JkP+xVi8XVTj0AbODaAgGMybj1xZl9VCbr3fcgmmB80kb+Vc
	 08hxcaj/q1ELw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>,
	Dickson Wu <dickson.wu@certik.com>
Subject: Re: [PATCH 6.6.y] wifi: mt76: mt7915: clear wcid mask under mutex after RCU pointer clear
Date: Fri, 27 Nov 2026 12:01:20 -0500
Message-ID: <2026-11-26-1-daily-reply-0032@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126-so1-mt-66-v1-1-429a17b69783@certik.com>
References: <20261126-so1-mt-66-v1-1-429a17b69783@certik.com>
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

> mt7915_remove_interface() cleared the wcid mask bit with no lock held and
> before clearing the RCU wcid pointer.

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
