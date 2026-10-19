Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443369;
	b=DCSswBHfzY0/vWyzwbstTYtv8VbSNAhuHnw916+AimbvRdQAPuxcj1oK/Z+9frRiFO/1
	 STkmJMKwN0OCdjFix9insOkqoUAFClACLPoQ4bIt6oJLdDwpGM5GAYltPKFPuLbIJiflw
	 zHBRlpe0tjDfkLY88F5VeP3wsyceov0VxtEjqKKjUCRPg6TI7cCAqCCKDUTWi5KHmhV8J
	 lw3ctoSRAyN7qFxlwZhShIOtLTTWBoR9iVhbFfU2hNMTQ3RjCyehK53lRaKUABJkT1Y2F
	 TMrALAs673mZ2sqQVEmVVtFnAKgDyU+69tdVO6vmwywOc7BMvzwo9Wpa039WndaqQig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443369;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PBjfrHzm/OKBuKlP+dIXBXkDVnP1alo35u4bRFvw+Pw=;
	b=h0EeHo7tumwm5hzVgFwIBRkOFsRzR3fVspRwUFfCGrVEh59bakF7C1PRSJUKAUzy81K1
	 8VNBG/E7t/YHdAuTm2smO73wNSi9KkVnmNX6lOXnYgPKkK2oTbYmPHg/NasEjHTjPuN7w
	 u7CAI+f1DJ9sZpOy7NLoysfodnAzKbOx0TLj14Q/N4FJnhbUVwNms9pWysqTpZKBi2CwS
	 9ujmktgYTRMg+kQ73U6TkaycgfNc9yeg56vJ7reTgS5LoDNMLT/kVKztUHW7NepRVtoIJ
	 1Up8Po4s5hBhCt5/3XwPyHiDfyWaSx+TAzhXjq4rCiTB3dOobJ4qF5WVlwQou77ET7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxcqLrfH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836C606A31D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxcqLrfH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A98E1F000C7;
	Mon, 19 Oct 2026 20:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443369;
	bh=PBjfrHzm/OKBuKlP+dIXBXkDVnP1alo35u4bRFvw+Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxcqLrfHNbKP9mFjGR0uRo9csVSB0P2IDQq2LmKmDYcdL4XHkQL/S4cJmBpZ5ocwk
	 4mDOvBxJp5Awu5pTOqZgS+NZgTeRuxOebzw/aVSKmj9RwcUwfwSEFt3eydtZINtQWH
	 U8XGEpkj2rSvGkaHyLjgoW5XESBmPVLjBVJJHebeomO0AdHyauyJ3+WaLGFU2Wfm9w
	 /jpYTcVNCuViaEuWk/bLVoQwWksi5a9vMdCiA0FD11ubEB+ZepTm1TaFmJQYcHDbTI
	 Q3FAOmodehd1xItMqx4TbnzB3+1KMchlrQ0zs0/YV+WLWqtY9oZjcguYqwEQlh/WuU
	 0INqU3lr68sJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Chiang <andrewchiang@microsoft.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: Re: [PATCH 6.6.y] ext4: fallback to complex scan if aligned scan doesn't work
Date: Mon, 19 Oct 2026 16:55:43 -0400
Message-ID: <2026-10-19-1-daily-reply-0018-ext4-aligned-scan-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016192018.839676-1-hamzamahfooz@linux.microsoft.com>
References: <20261016192018.839676-1-hamzamahfooz@linux.microsoft.com>
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

> Currently in case the goal length is a multiple of stripe size we use
> ext4_mb_scan_aligned() to find the stripe size aligned physical blocks.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
