Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005605;
	b=r5+sO8Ci3R4VA+JbrNlSM7sazdiHuse2XkiZxJVhL/u/5b3aYcdKcTL/BFo71weWRdHm
	 veqxL7JoWyU86WytFQinE4T72TIM5IddKctIVD5Av2jsMS0gFolVqq4+T61Z0U0FfrN5m
	 TOp/1OZAie60KtPBgczZLkZmlf8rNULe0r1D9fcLDenj6wYMICRFnxU7zNfwoKoEX0AZS
	 xOvdJv8imvcjpiGuRstUin+dd5am0Yg1dpcpwc22dTleLrSIYJ22AQbws/IE6dETU10mq
	 fPNjLJgqeIDb+y4hDDKRN5mPjrnsFl4CeKNX0ajYpQgJRQgYt7CdTw/X4JI5K9676BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fEwBFRFlykVi78THwcp9kuiT6jItZpH6ih9H1rJHzJU=;
	b=KlYQ0qlUZlhGbS79tCEoTsavXr+kiXozQLxpGkQbDoJtX3bytK9qHbgu+jnrLvkMyU0+
	 +qQ5UpRpctzocuvu1mTdpH/2bJ0KUvSLLvN7jGd85hrbS1aCnrKFqRFo4GcRIcqDiYe7E
	 vo5oFwCReovJRs+JU2lJEu7AB/XTUCEqn6CD8L6+e82RmjWO60OtRErVTaoZC0VXkbiVd
	 U1WeA+OVKNkQV6lHDQhYWOYb2IEf9weU55IwzC+yucJDHlWBCg2CK0xl/oIlei31fPbgF
	 4CM/Oqd1k+A5On1Po9PQB7vVz9qPOWcbi2/T6nDVqofuylVBmyIl4u4fl5ZF9ugDjZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjIHXa+E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070AF606A320;
	Wed, 18 Nov 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjIHXa+E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC081F000C4;
	Wed, 18 Nov 2026 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005604;
	bh=fEwBFRFlykVi78THwcp9kuiT6jItZpH6ih9H1rJHzJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NjIHXa+E0Oi/Yb9NPF9Es9gRIPbYkqn67uzYcZMQYmUUXQxjG3Sk58SqhhODT6rNi
	 Xy5Wqa3UpPrjkD5qN+Cv3/LWRTJt0Jrc3hzghyl/TNXm84+Ty8yj9afkB/n7g8ueT1
	 JP04RDDPKeIY2tl98Fx4140yW0dgQUqBZgaYrxgvw+29GNoXWfqjW31ZHENbC9NtsG
	 V7F6x5Y87aCJY0LF00ZyuxJcOKynFrO/z8FxlOHEwm3Zy21Hg9cVZah6H6lPnG2h6w
	 H28U+PXavZVu74ITmRM2BlCtERFxexM6Y+lhZiL5ETD7IlI0TnY3epfdLqYA1t9iCi
	 r8pjGZtOVrRRw==
From: Sasha Levin <sashal@kernel.org>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: Patch "power: supply: core: implement extension API" has been added to the 6.12-stable tree
Date: Wed, 18 Nov 2026 07:39:57 -0500
Message-ID: <20261118124002.3727477-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6ffbbf17-c105-4ff3-94bb-ede950f574c2@t-8ch.de>
References: <20261117173125.2151200-1-sashal@kernel.org> <6ffbbf17-c105-4ff3-94bb-ede950f574c2@t-8ch.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 09:47:41AM +0000, Thomas Weißschuh wrote:
> This feature backport should not be necessary.

Dropped the extension API backports from the 6.12 queue again, together with
5b4bd13e0552 ("power: supply: core: prevent unregistering a power supply while
a callback runs") and 9f7f7a859451 ("power_supply: serialize property access
with unregister"), which is what pulled them in this time.

9f7f7a859451 is also dropped from the 7.3 and 6.18 queues for now, because with
it mt6370-charger, qcom_smbx and cpcap-battery call power_supply_get_property()
on their own supply from inside a callback and so take epc_sem for read
recursively, which can hang power_supply_unregister(). Mainline has the same
code.

-- 
Thanks,
Sasha
