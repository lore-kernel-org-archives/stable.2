Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794084348;
	b=S1KSRo2+j2trU4zMcfYlSbuYJNVReCgQcL2uXRopn+HPdQwdPzH8X7ZOq8RIsGM1XaB1
	 ZRcIgF7O01wA0/lxLgS00pY1JhM+nO2/7Uk/nfnBaGiFVGtNwEtgP8Y37+vYH5MAIDUUZ
	 snkpgtm+yf76K79MZr7OHVNZrHBR0b9uLC94iGpHeXwQNerXvpAk/zhxlmz1a2HuaU6ob
	 +C80TSdEDJBKhpbXdkR77595nMnJlg+s4bA/C4RuaH7/AT9Ph0UU0i3uWTYdOkJa4DIsW
	 0ZBbTQJluM+Dd8PHEcF9D8YTwveVlQqHWVrwTu6MfGvx3THN2+tzrZwsNN2B/uXN/6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794084348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M8bgwxspFahVCZ0yH00o4YkH5qoecwxn20OJ9z9Hb00=;
	b=FTwj3JtUMP1zrK+n7Usw2NBSYLJuoD5sIZNn9wkYboy2EwSEoCaPYy0F8vB0Yw+lz/3J
	 AYvM7XPkc5QKBIzpSOqX7OmavZ85JfopZyTO8O4XrvMKY1zhzsMUFS8+TuTEFGer8R2qg
	 6sNI/X48vEDEcyATEmvyImMw67p5mEF2MfyY7LFy/CSO/ippiLElY92KvKYZpr4bnStQF
	 X/K0KxgUCs4oXO7+0anc01ANfH8FJ1aGipAxmJgUAMGB5P7q/bEKHOfcMolVqYDlnaYgk
	 N959B8eyOBhbe9WX7AQFW9YykuxN1HUJ1vQxdywpPY9tbjA0t6fNUvZ9pFNyzAwbeBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClSP5JC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BF606A32D;
	Sat,  7 Nov 2026 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClSP5JC+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8257D1F0089F;
	Sat,  7 Nov 2026 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794084347;
	bh=M8bgwxspFahVCZ0yH00o4YkH5qoecwxn20OJ9z9Hb00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClSP5JC+Ctl8qE4ktkLMUrfT3cqho0khiqd2A9toxiep84llJT4HyJAnHGa8vNi5L
	 0F9J3i4zDRPk7YvOreWsgkdlLixOryDqlWwnWY07nOtFOvX+6bQVoKT5IPAGL9Ke4R
	 Uu/Ficnvgi5obENWFGYRw/sXhzcdV8HtZDcOtUGGxxcB8S0e6euDLZgvgbXUM+NfHy
	 wusRwqVKw1ZYEfrTAwDVENWH6nwm8o5XoejlSOEUh98PbOyKcQY4DRcRs2Iw1MVpvH
	 pZmLCIuE4ALFxUx9HG77QkbpunioOgA53DYCpQxtnrQgXJYuGo0r3q1ILy0i+OKQ/j
	 8ak58/WJ2YzfA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com,
	stable@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: disallow max < min damos filter range arguments commit" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 12:45:39 -0800
Message-ID: <20261107204540.256103-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107194352.198354-1-sj@kernel.org>
References: 
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

[...]
> Let me know if you'd prefer just adding those, or finding and dropping those
> wrongly applied ones from series before released.  I could also help in any
> case.

Maybe I could identify stable-rc patches that don't have 'Fixes:' tag as
wrongly applied ones.  I will find those from current stable-rc trees and
request dropping those.


Thanks,
SJ

[...]
