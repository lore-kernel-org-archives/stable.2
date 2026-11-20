Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207181;
	b=cl1Cau4pMcHV3+KECqq17wn0XGW8Ul9vyu4G3q9gcmgcoz+ioUHaZnNSkc9eEWm7p/Fz
	 ZQUFoAjV0gkbZiqHVvBB8wLOMCDSjaEh4hx7tqgxsk2BoUC3cR7u2b8JLNVpgYXdJe7Tt
	 sq737xGoRTVJMYsygxNP9nGsJqHH1jokMs+oHjIiA/G0aiQrMCkrWR97YNkxlx7Ca7kkG
	 TeVR1AqY/rjIIDABRiMK9sEmecOGz2kq8VBYtW9+ZBXQEzpDFDJWGu3FiMhRR9Cw69wwA
	 fgVVXKVzsF2s2WS55h89Gd3mSRLMvO33wBfh3/MpndWgk2csumg94+lMS2EpNyyJAfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207181;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pY6DjsJ+Q2uAhwKQJScEX6eWIDNvVjo/J+BMCkWwohY=;
	b=rGRUcy+j0G8g5MGIxrMkd31KE28ZixYZTExktTnvW1tgpq0zhY6T5cNn+vcKZslW+6kM
	 6mcogTEmulz7LOcfnNXt2fJIHcN4iHp+6b9vPkKl2hZhe0aXpu2MEsx65wxyl+rLIBICF
	 W9m2CslzRHnfqikfFePZvRQDGvX73Yp3S6CMOQtiHQ0uXRZ98PhoONUfrcMi5jVgtl9gM
	 o7s4a9GepGEOv4uzhFXM187d9MxTcHL26rHkFgTZnlIH7vaEZFjGVSt53b9TvfUYrbKSF
	 j3kGTJKFvnCmE5umOhfv3aA7QhvyEVxE7ovjfUcAlyBIZFlkJLvbdGOVCbmOmlQchHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYLdB9VS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE47606A6CB;
	Fri, 20 Nov 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYLdB9VS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525651F000D1;
	Fri, 20 Nov 2026 20:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207181;
	bh=pY6DjsJ+Q2uAhwKQJScEX6eWIDNvVjo/J+BMCkWwohY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYLdB9VS4n9wYlIkhfgooJPqI9vh5n9yjTvyWkj/lLWBH3DM2SNSBaraiwsCosi3m
	 cE+GoYOzagITz1yHr9emJv5vWh4qp4i1rC2Peu1fVuPIX0HVuDNGl6AEATkURHylcX
	 Q+HVCc/WM++XPjpkoCPQFstB9s5oskhxCeRDeeuTHwH/aer0uuM0szo1u1Nj2a9fik
	 7Sy8LKbmzovrKSJvUU5Vr/F5p+B5P8Bg9S2X+xjMn+Yisy87IBPQaZiXXXqHsELD0q
	 xI7DmTJnkP5uY7cBuaQ/K8yO+MKrI6WcQQNGttNql9YTKsiscI7dQPB4oHAxjepAaE
	 ymYyrZTMkO8LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org,
	Krittikun Wongnin <krittikunwongnin@gmail.com>
Subject: Re: [stable request] ACPI: PM: Add Acer Aspire A515-53G to dmi_leave_unused_power_resources_on[]
Date: Fri, 20 Nov 2026 15:39:00 -0500
Message-ID: <2026-11-20-1-daily-reply-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120082631.110172-1-krittikunwongnin@gmail.com>
References: <20261120082631.110172-1-krittikunwongnin@gmail.com>
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

> Please apply it to: 6.12.y, 6.18.y and 7.3.y.
>
> It may not cherry-pick cleanly: in mainline, the entry just before it
> ("NLCC 001") is missing from those trees, so one hunk's context lines
> won't match.

Queued for 7.3, 6.18 and 6.12, together with the two quirk entries that
precede it in the table, thanks.

-- 
Thanks,
Sasha
