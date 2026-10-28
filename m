Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227795;
	b=yjaTdCuw5vlE5xJrzqBA56Q6AoLRUUbUhqUdhTeWUHOA0mDN9DOOcusqTszUAtqw3acf
	 ZJ0qaF63jMyabmZq2e39t1kvJypjIjWL9CZjlgIurdPLGBUx2mXwUwTx7QQkYAfD9PcRK
	 guUwDdXPUdeZdzzSDOdxM7+XjFTRdeVn8ARoKCqCZqYB8ERggo1MrkPDi40ita0EMVKmC
	 iB2Ic4VaTOS/QRG0LEIhIn4Z0JBvTvAaUcpzBlfQs4TD0g5MvVskQ3aFElh6X2e6RWmdW
	 N+HybHOu5ubrSn0srpI9HEaKYr8KIblzdyaE7xooNpKf03xFbVK1OtnbBLFxcvDp7NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9CcVGt9eIzghp0hNtTKb3LNk2YarqbM5XVU8xqD+QMk=;
	b=vsL6YNNBFEnxNdXcK6kmZ+b4aeft/McfXMU8MwXr89NW+Y7x3BPlyjM4A6+oKedC8E66
	 tEd07sG27COmLp0xyfzvIhbUU8DxHzuOuNQZCKOOQf2StB7g9Jw/VAZS0/j1kQlrwqu8B
	 IT29DB7ROkHVngIYCyGyxXScv12WWE/WuB4so3Iv/jgLsjMBYPFgRZ2vL6RhYRJIZl1Kp
	 kE+4Gtj6nSwXDmaV6+E2c+8fsWgXBgfg1kcP6hzSpIoqb5fsi1haWgITd2EkV0TB5lHxn
	 4acfFWz1GcLGMgkyYI6m53ptaMVj206iLi8t0H4k5KpWsO3a3tcWGfSQ+aGhcXd+oXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=nQohm7Gh;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E970606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E970606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=nQohm7Gh
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB5C43FBFC
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793227792;
	bh=9CcVGt9eIzghp0hNtTKb3LNk2YarqbM5XVU8xqD+QMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=nQohm7GhYDynutXcxqUVrfFVxVO/VnOl+i9WvPIZ5N8Z0E/c9uOrZl7lbKLheV6Vq
	 a3N//GzglgOc476oBcjvgyCVvq6/KbkrqLTVHyfBvJE6OewpbgAVRkB5CLDeShKXgG
	 vzBiAV7774fG+9A56Y8OfhYv5GKqPLSKcLel36HcLPfh/wjDJa7LkHLQQZbHnqj/4q
	 fhL3fbxDqOH8bKchUgJzFKEc0h+lg1cIiXjxrfTB670gKA3ezF1m52tKYzz023bMkC
	 HrVMNCaePYAkVkkCWwRapyUMHgtCacf7I4DoxqcqUHA77tJ6Xv8bs6jJM/kd87db7E
	 GTQF+Aa3lHihKxy39Pk/uFC0k0uYQAO3aUmXIbDwhqTjXNJr7bNBPUJgI50dz/iCpe
	 brU01NiuV4tgI9NPvWw9JKcyeMptEh+PP3rXRz1mi949hXh1zGOE+tyjllAdVSzr5W
	 cN9S5OnNp2i9Bw9G6ZmhOYskYizLnRDxN002vWK8bM9RgbwCshJl2D2/q+QKYIU9Zg
	 BHaTcpwLoflGqHe/quzzPcR6EhMCFA05cLKmmfhQaClEOwyGQ2Xf5BabnPQR7fprFk
	 MnpFokMRZFo85a8AFQKL+c4UMWNYkhlifFHnRHXJChE8mhSTwGvgXvtM6wbwKnwRaM
	 EVBZ//MMXVT4WAVAu1lR2iD0=
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-836c9f68dcbso25244967b3.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793227792; x=1793832592;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9CcVGt9eIzghp0hNtTKb3LNk2YarqbM5XVU8xqD+QMk=;
        b=F+HsHf0nVxtxDVFhgp116qAQBp8rquwtmnOMgSMinszRmVLHVsKAuo0nTV/nAzmlCL
         dJDwcjHtybk9L0cuUah2hqnr91OaGcAQeak64dTsFVvOtGprDRjG5XQu+yloe97YFoUZ
         ol/T2jtDOsSWjGfGzvzXBXZuGkfQXYKF4M6mDhGPfVjDROMIv38gUi8DCDOfzIjh2e1R
         c6g8JWFvoTgRdWIl8UqpeOSdlbHy/blnev3xHr6iwlHxcbmoof50lszMzW32SHtP8dC4
         FIVoboy+ex6lrMyHnsZqbz3LTfeMbAQi7TFQ3INXShgllqhNvafkAxdI3DtF6tmWBApy
         5sVA==
X-Forwarded-Encrypted: i=1; AKwUvBzdcqqSuXOlvZ20bP+6q3t/b85NfeClVllOYa5JnEjt7oLfugdWNg4xWzVNqRY4gmkeJqeJ4V4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJZHbcPgh8ozX+U0oeRVx9WQ8+OA4G77wd++OR1IY/+iSDFStK
	SLqkBXXuZuq4kLDt3WD7ijoCv7d27kATPLHlqvTUrya/emNMBqVd3KRq3bCJeePf7n9FQU7ZPiH
	1RbLECawLOb1ZiiCVuP2lpKCGGLPJj7usleL8DYmnfcBy84cJWOhNcrPf1rPixpQVUC7Zrz0Thw
	==
X-Gm-Gg: AYBFou3gIfUNG0GnfXGm9EvVXCK/Nw5BfYxxiVJxF6dPEBY0OhelPY2asYv+CUSf7Gp
	7r9u1jPVu4aaIppmymmzLfyP+dalIXDm+5A+4mTCPg32ShTP3V0cUWvKKLMFrboUR9xXoXfBCKR
	F72bO6ETJzcCwF0lyErZ8h4z/wKZQMzqCjGBMoWNJrnchE8Hbzak7bmdGN/icDUgXPNp+fhwDKO
	0ISr4QGW6w6M9uTj10oEySbO8IwWuedDqfTdy/r4j6kmk73pTuFjUOcCdt70wxZE+XJsCaAhnDX
	Q5Vi9cZxdrvIEiBmMXL9o2XL2e8YvAKTflRUekgEpe+zzkOQu0VOLlQo5AvPj0rX8wFeq7SQz4h
	Jp8yJgv473CVIHQIKx/kQwycAEXcjnG1sYKHiJmzNeA/hY9mUHoCtecHzT3d7Uv0BdMzlkUpFe2
	ne2MBN3EYYJo5OeDS233nKkISQOuxi
X-Received: by 2002:a05:690c:418a:b0:8a8:85d7:265 with SMTP id 00721157ae682-8b1b5ba6fdfmr17679597b3.36.1793227791887;
        Wed, 28 Oct 2026 15:49:51 -0700 (PDT)
X-Received: by 2002:a05:690c:418a:b0:8a8:85d7:265 with SMTP id 00721157ae682-8b1b5ba6fdfmr17679547b3.36.1793227791517;
        Wed, 28 Oct 2026 15:49:51 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b19e656162sm36374807b3.44.2026.10.28.15.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 15:49:51 -0700 (PDT)
Message-ID: <58cb4243-99ed-4310-99e6-d3a2809655e9@canonical.com>
Date: Wed, 28 Oct 2026 15:49:49 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix query_data() output overlapping the lookup
 key
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
 Georgia Garcia <georgia.garcia@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Francis Perron <francis@akrites.dev>,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
References: <20261012215703.30592-1-cenzhang@linux.microsoft.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20261012215703.30592-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 14:57, Cen Zhang (Microsoft) wrote:
> In query_data(), buf and query point into the same multi_transaction
> buffer: buf at the start, query a few bytes in, and the lookup key
> right after the label string that query points to. Reusing the buffer
> is by design and is safe as long as the query is fully parsed before
> buf is written to, but the key is not: it is dereferenced on every
> iteration of label_for_each_confined(), after output has already been
> written. So when the label has more than one profile with a data
> table, the data of the first matching profile is written to buf while
> the key is still needed, and overwrites it if the data is large enough.
> The later lookups then run on a corrupted key. Besides, if the data has
> no NUL byte from the key's position to the end of the allocation,
> strhash() -> strlen() -> jhash() reads past the 4096-byte slab object,
> triggering an out-of-bound read:
> 
>    BUG: KASAN: slab-out-of-bounds in jhash+0x595/0x5e0
>    Read of size 1 at addr ff1100001159d000 by task exploit/155
>    CPU: 0 UID: 1000 PID: 155 Comm: exploit Not tainted 7.3.0-rc7 #1
>    Call Trace:
>     jhash+0x595/0x5e0
>     aa_write_access+0x880/0x1400
>     vfs_write+0x26f/0xd20
>     ksys_write+0x115/0x210
> 
> Writing to the .access file is unprivileged (0666), but triggering this
> requires loaded profiles that carry a data table, which needs
> CAP_MAC_ADMIN and is not the case on default distribution policies.
> 
> Fix by copying the key with kstrdup() before writing any output to buf,
> so the key stays valid across all loop iterations regardless of what
> gets written to the overlapping buffer.
> 
> Fixes: 317d9a054e1c ("apparmor: update query interface to support label queries")
> Cc: stable@vger.kernel.org # v4.13+
> Cc: Francis Perron <francis@akrites.dev>
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>

Acked-by: John Johansen <john.johansen@canonical.com>

this has been pulled into the apparmor tree

> ---
>   security/apparmor/apparmorfs.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 5b42140e12e8..9df06fdd894f 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -919,7 +919,7 @@ static void profile_query_cb(const struct aa_profile *profile,
>   static ssize_t query_data(char *buf, size_t buf_len,
>   			  char *query, size_t query_len)
>   {
> -	char *out;
> +	char *out, *keydup;
>   	const char *key;
>   	struct label_it i;
>   	struct aa_label *label, *curr;
> @@ -941,11 +941,18 @@ static ssize_t query_data(char *buf, size_t buf_len,
>   	if (buf_len < sizeof(bytes) + sizeof(blocks))
>   		return -EINVAL; /* not enough space */
>   
> +	/* buf overlaps query, keep a copy of the key for the later lookups */
> +	keydup = kstrdup(key, GFP_KERNEL);
> +	if (!keydup)
> +		return -ENOMEM;
> +
>   	curr = begin_current_label_crit_section(&needput);
>   	label = aa_label_parse(curr, query, GFP_KERNEL, false, false);
>   	end_current_label_crit_section(curr, needput);
> -	if (IS_ERR(label))
> +	if (IS_ERR(label)) {
> +		kfree(keydup);
>   		return PTR_ERR(label);
> +	}
>   
>   	/* We are going to leave space for two numbers. The first is the total
>   	 * number of bytes we are writing after the first number. This is so
> @@ -963,13 +970,14 @@ static ssize_t query_data(char *buf, size_t buf_len,
>   		if (!profile->data)
>   			continue;
>   
> -		data = rhashtable_lookup_fast(profile->data, &key,
> +		data = rhashtable_lookup_fast(profile->data, &keydup,
>   					      profile->data->p);
>   
>   		if (data) {
>   			if (out + sizeof(outle32) + data->size > buf +
>   			    buf_len) {
>   				aa_put_label(label);
> +				kfree(keydup);
>   				return -EINVAL; /* not enough space */
>   			}
>   			outle32 = __cpu_to_le32(data->size);
> @@ -981,6 +989,7 @@ static ssize_t query_data(char *buf, size_t buf_len,
>   		}
>   	}
>   	aa_put_label(label);
> +	kfree(keydup);
>   
>   	outle32 = __cpu_to_le32(out - buf - sizeof(bytes));
>   	memcpy(buf, &outle32, sizeof(outle32));

