Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274873;
	b=gxQ8HF4yCEkH2x3BgqqJgGjjCebDZ4jQhD2H8j4/zCSwKj4GGbg8Gi8PR0mLdnOhJbCH
	 2es5705USJHArA9rb8xuA1XkmHpnkwo0c0rr/1jMIhdG2SvOvry2UbRw4eobpfUUHcOdV
	 rPkCegkEccOGjDE2HcaE/y6RTCNvlIPDtNx96QpvigJjqaEkbvMvwnfWLn5V5fSEbVUcb
	 Gld/g3MVAhHQxziIMlDCwlDgHhVBoWUpfGD5E2ZzMQmQ0ulZUNZojs6YyO1DoeooxXw7R
	 bN7MyqwNq6sGVwbOUnMu+TvdT+8q89uNw+grQAtrMYN95HgnBCB3WooIUb/rIyuAzjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274873;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pafVxBv4nunTZovZrCm+9PQBgl4nSgT1ZNnL9ewxeE8=;
	b=ToOwBjwllb6T9rqD6MrYVIvRitBaAsp3VpGKRUfbctJcdKilDeODVCxWTdUVIfG4FuSL
	 HD60fP/DneWLbQWglFqbhZMvOsJkdYcAL8S9v+v1nJnUsiAg+apLKzWlJdipL2Nehaxbx
	 vpjQcZ4iwEUyWcrdaDeClTt8gwR4JesspQPG3zbdHr7vK2LeaLrNntN/o8NR/BrOm5vG6
	 JZ/HQ5t+0kFFlT+UeRtnCYk6tz6ZbfRadfIvJGdaMrviXG+eK0EaCbRfIVSOgNu1a4OJH
	 EGMdE36Yz/OPZG5ETH6QIX/CnSLk5b/Fj4TE2tptFYEbM73KliPwGsDTy4mYoEf7+lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyVdvHBE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2328C606A33A;
	Sat, 21 Nov 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyVdvHBE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADD61F000C6;
	Sat, 21 Nov 2026 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274872;
	bh=pafVxBv4nunTZovZrCm+9PQBgl4nSgT1ZNnL9ewxeE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QyVdvHBEm6Ymw30A0NLOwESNzt6eJWvCfx7teJ93YXIt01AjBntAm0o/ZF1iY95il
	 Wr4pdSweMqq3EL+4WpI1oqmeXgg0m0u3psDxqC1MUneq9F/kmGjafFjakV3MBRNldj
	 Cm9zHKKkCy7Gwm79eP+syYYiKUfwU4c+XJvtyjppRr7XYlnKrdIFSNchsEHlDx6P47
	 1YybUTzJAcQpgZjuZgG5H70Xtza8miLn2lfZXyetPqsZf7yfMZt88cRsQVhknqki3X
	 fbDaykDiYkgc+NSIK5VU2Zll4TQHPqUxtfv+fNEwSPtKFgj3Dtn6TCyuZTsYWewZ6/
	 GUCNSsBt9iskw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [6.18.y] Please pick ACPI platform parent lifetime fix
Date: Sat, 21 Nov 2026 10:27:33 -0500
Message-ID: <2026-11-21-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120192336.26131-1-artem@trailofbits.com>
References: <20261120192336.26131-1-artem@trailofbits.com>
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

> Please pick commit a9ba4dd2f18bf3f439d9ef0d8f375f90360ba1bd ("ACPI:
> platform: Use acpi_bus_get_primary_device()") for 6.18.y. It fixes
> CVE-2026-100072.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
