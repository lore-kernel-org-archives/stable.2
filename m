Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798962;
	b=QhKJdalTIlLGv1DCDVtx+5cJ2V5Ziozg/kGheQRBSvnM4xZjqQuqElTqmXjtZmvBHFef
	 Sq4BCfoSib2h2BR9UeczX8kFEsuvkB2v3irRSc4FWlJtRAd5rjfr+aeM5ehriufofJJre
	 nSwAJyo/Arg43jm63kE9szthkTekvwL8hwpPHAMZWbtMVpLPjDwWNRZMnfqtqYH6O8gNi
	 G3M04UZwZu/fOb2l2Psp728lstNWg2MnRotXns82Zw6d3eeCvC74/hPYDdBnoqnMM6yy5
	 ENsiDrRWl3UUQbp2wd+Lh660G6VnV4KaCJokOQCfiizQI5MxHBdg04K73QIUkhOfN7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1AQ2dn++OeTPMW/28ajXyGUbc9l/EVZLErOmBht39ZY=;
	b=h9NcBfARdCmaUrO+wSXXyIytnvjnk7OTkfAHfrDuQ5xvLtZjJVolXxtEsg48YCr7o1cb
	 oOYcqtvN4/+auvWK2NbVLZpjpo9pT8cN0vrFMeVuN3AGdTCnVa99PLdaUgsIu5wM7LLZp
	 tgcrTglLA0mloul0q6x5nILTqQ7Mt2apx0/GR13zyGDGyH/vRvfTTIL0awEqid8STy/CY
	 mOFHOEgF1MStRjc1WvL9YBpmwmLXJKBgzqZSzSUG9thXe1yDBNDCrnmu0rAOHuxCff/C/
	 OtGRvBkY2Wtrm3b8uv4ngZNd+F6qzFmRuO6fts5XttME6aFadlObhQXUeXfcEk8//PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zpqxf2Mw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7EC606A333;
	Fri, 27 Nov 2026 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zpqxf2Mw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6641F000C1;
	Fri, 27 Nov 2026 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798962;
	bh=1AQ2dn++OeTPMW/28ajXyGUbc9l/EVZLErOmBht39ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zpqxf2MwglVrI1xGj5Xv4GGGeEUcM3N9YmBKuWrk48J1jFYFXOweieigpOpJBfVD4
	 Lu+6MIqGLFrxHE8UTrqSHVNw5Ep7lFnojqE+HS/sn3DJH38xrm+yBNDu3gSJP6KhQy
	 OHMfGTo4YFB3cQBsCzFOgI+byMUOxU02zOsmiA2QUn/Ds/hQOowG7kTObrGnGPWA42
	 T0FP2sYOHqccLxjUaIvQvW5+79KzBXgJazdj8uNB4AiV6nJGXNDtfxCc+32qo9Zgj4
	 NCZ2/+deCKRFadgHdlkUVdn8cMbLGEm+6PJYFFymY40bFQINO1xcqttHlWSsXwt6Fv
	 zWEeEFo28al0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>,
	Dickson Wu <dickson.wu@certik.com>
Subject: Re: [PATCH v2 5.15.y] pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting the reaper
Date: Fri, 27 Nov 2026 12:01:27 -0500
Message-ID: <2026-11-26-1-daily-reply-0039@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126-pid-515-v2-1-7f7ca8955797@certik.com>
References: <20261126-pid-515-v2-1-7f7ca8955797@certik.com>
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

> v2: dropped the signal helper patch, Sasha already posted it as <20261028212317.2257095-1-sashal@kernel.org>; this patch depends on it.

Queued for 5.15 and 5.10, on top of the helper, thanks.

-- 
Thanks,
Sasha
