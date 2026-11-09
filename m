Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212372;
	b=BRWnausF6t7DG4aHYCpOm6gs0aePhGr7hANsFr1WuiSfCo0027MkAh4jbdxgH3pkfqT0
	 jnu+rntJmrmCgXC41Mhe9KHa2ZuIqBy4d2QjTY/pxFzm4Ui7Llzc7AaVTT7EluT0E16TO
	 li7DBp02vsdnvW+tGE5l1/GEeV9LziNvlvyYTJYfP5qCoEWxUhxyhtr8dAiZpmx6XDDpM
	 yAlLKePaIxsKUJkzpb2NQSUmlYhLEOLyvauQ68wa/5r+X0qoFluq6u5hT5UwSgNYfQGYe
	 dPt+aFWU12WRRNdx1hsfAYFMgNzNzftyP9rk9acXWmrJ5f0+57kphQZ/miv5rdbhBmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212372;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FD3v7AJwy8DIFmDfqblW2JXd2GdEynyzTfuggqPhEMg=;
	b=Ljkq5W8SEGVgsLcwRSLZPtcsD4l2N+BW9WUxzL/8fGnAfHSZxo+QzRgYQL+LNz+wsEVD
	 GRNhLOsLEHcDDZkYf/5vnarlVhOHUjJWTPFgQ3hzTOZxcOmpSWX0AlQu0EPTUTcG3QFEF
	 lKbK0GYJ+rQ5d2GiFE8twOp1kIm7lN6s6acpM7Y5Xiqnya1+n+r5vCG9JTRFdSWV2C53/
	 BD1WlboZckwLacm7kHAJf6RtsNyrXMHP0AlG9OYEnlrp89A1fW47bV0G7Aj2g/BG1FMqE
	 tVP1s3qWcgvtWTy2PqBwcEcEJfRkXNprecB64c3TqBcUrZu+cGCYKQEp4Xsr3uxBOLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=MF2yaVXa;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A859606A31C;
	Mon,  9 Nov 2026 08:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A859606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=MF2yaVXa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794212364; x=1794471564;
	bh=FD3v7AJwy8DIFmDfqblW2JXd2GdEynyzTfuggqPhEMg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MF2yaVXaYM+VMnZcgF2uk9v79PkSQEk97rWpg7qMLROKI7tx1b4TX2nGyuP0Zfj+d
	 xS1jYjasA6uh/jR/uhEa/0qD9yNzcFBWCICm3n1jlg5FBfqb+mHR7KqeKPaNZjWbgN
	 o4AS4ohPtWsi8GA7eeBD0JNyZ6pKvUiRX1GaFBLyeGLeZ6xJ80cqjJRtLk+/2/s+Mj
	 Re3DJBTG8Gdq1TqWpkTNEuBSDb5YydZMys+GAmSPhB7AP2Q/SX8xzJ8MtVcAXRBwef
	 OOQArHXR9/TjyglIaw9x1QvBQp3K9274w0EvEjXkPZ6PcZU1e15jTf6+rGYsXXG/UR
	 snq9oMJzBq5Ug==
Date: Mon, 09 Nov 2026 08:19:20 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ACPI: pfr_update: keep the state until the last file is closed
Message-ID: <20261109081914.276006-2-ca@modelmiser.com>
In-Reply-To: <20261108233900.4043941-4-ca@modelmiser.com>
References: <20261108233900.4043941-3-ca@modelmiser.com> <20261108233900.4043941-4-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 41114a838137cb3b14372a20ac78bf9b88533a33
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shuangpeng Bai reported this bug in June, with a reproducer, and I missed
the report when I sent this patch. It is the same use-after-free after an
unbind with the file still open.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/all/178144969601.60470.7781990940097306115@=
gmail.com/

Chad

