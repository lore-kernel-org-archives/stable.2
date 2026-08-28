Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3D2C3255
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922136; cv=none; b=KGIG8o3K4rnpr5mT8s83pHL3JuWkm/VgfHWfOH3xFtlqAEnYXasHjXHyFepaDy1UyyG+eE5mJ2aXs4Wdr7vsoBjTyWOPcbOh2Wr8JsKRvG2mR5q4Bj5dmN/aPEkHKg+e9RDC9U4PVBz3OgNl/kjMspVCAkGyx+/4AQMJw8qaD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922136; c=relaxed/simple;
	bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0CEHacp5ZOLiw0Dq37ccDMSnmY17383OAh5Kn6hUgi2xmyMWCwd9yAvuofqLhG1ML1pzZxdJJvbON+szgJG2R3qjt3EEPgf0bRYrsuZ6osyM/NnoMxPrTGA/RrC1cWtP3js2kzhdJWHx23P1/qbffYEkHDHeWPj2IzfO2At2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKsP1TlU; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKsP1TlU"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66d2b3092c1so1605582d50.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787922134; x=1788526934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
        b=MKsP1TlUYUeUNOdu8V1C9pJvBi81lkXLkE4S1OivElINshuP9DPCx7gJEDVul60aHQ
         O6B8RkCPTl/CJXugP8mwR1OJ1p9m7ehYskD57AhN2ZDz4e3nRDERritZPgjVEu15LVRy
         nBSSaGRzdLC6jxTKqV4u0vJrtDSn3xph1F3hUgPdoFYxF7vkLRnykoDYMNBik2gI0Hdo
         lf2KGngS4ZsxTN9ChjAxBffVjb+DNyb+QTNJN9V28T1YjgIyqb3CULf4ziTeNelTNhBK
         xFeJxN+/grPnN1+fjaQDj8OD7TNyOnM0mfJ4naf1cgSoxicUCvnF8EEiZIsnEijpR/0v
         RPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922134; x=1788526934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqzBBu7p8nODo/RmFJm1kAQ41J+L+8YvaBuNF7HBWYk=;
        b=IJX1b8GFBm7emlhJ70FWE/Q7o0VM9rg1rK9LoUc5FsBPtMwNIg/oYypPEw1NNA+Ub+
         FtAiGIPQaW7i1CekKYtpwzp6Z0M66ehybpmJKbEhZ7/FNmqPY2PxcY8WLkifuWDJz75C
         tbwqGXliAXnU3E6kH3Sdjdn2/FjmDTpXP6KdBekoahOyLUoo6KdjAWl1jTOdnp4NZAnv
         H0PTd7XLdpt9FsiI2/8WCaCtKqocvrdliICSVjbnCywRwvtrrjFgjq+tTIh7dg0Ed3DK
         N2/Yh6dLsSWoWRptDNWcCeasohHBjqF8Mo/19lfyQsj7dAj0+zr6kQJD5HXUop3CfMlR
         RNmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxchRCUhLzrA8C/onEEyXRrPjMwyqFdjIqueqjSTkMreTZvqCrdtJegPENPrzkow+ZmIcQ8dNc=@vger.kernel.org
X-Gm-Message-State: AFuF++mbsFmUiaGVfto92R0SHacpNOU6Hk8zXpp+BSJS3OX5tHp9NqGY
	jolJapMILlPed5x/TF45kwfcWlRkc8zXZXrKQu2cMMayxFNFVcLbHquF
X-Gm-Gg: AYBFou26mACsO/WKXuEPosOIb/1kX+zoNRdPAPFCsdZAdkqwe3OZ3iYhWw9jImiAcqo
	oxGTdnHBvAGvVRV7YOgjmU2MtA60IaU4igNJ6qdvu/dNE2JigQzRuJSIKCpiSvDWyv8NGGBEkP3
	iYfaNfy5w/pjuLM7RKMY/gzjOBx5EUUAfQJc0N+uwnH7S33tabMuJI3UBoMPBPOBjduMi7k7Q+E
	Vr3QNZvpYttHGL0T5GCIxNsHtIEhszP9DX30UgJbBN4+6wVBElvAP6AZof2DcMCxyc0nz8Wi1fy
	dm4JDDF87qyy7Yi97mlvtI5k99avXuuSFBY2IS3ryOD5Q2dYQ1D8Vyn2LbxZR0+xRUcqDtMcyX7
	9jMRS/yNpzQoYFP/BlSjyPhDNntgcIB8bsEnvsRlMYbRBNSupGVx2ql4ulcGmwM/RQhj9u9K5uq
	Cp1KNA80GaH4lFY9xSA1m7MZysZVgT0wHV5nFApBFwuUfQnzj04QQuoKVh0D0PvfeWhpQM8pkOh
	loMfA==
X-Received: by 2002:a53:c550:0:b0:66d:264e:88f2 with SMTP id 956f58d0204a3-66e4c6eb8f4mr1512029d50.16.1787922134170;
        Fri, 28 Aug 2026 06:02:14 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed39d4csm770568d50.21.2026.08.28.06.02.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 06:02:13 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: leitao@debian.org
Cc: AutonomousCodeSecurity@microsoft.com,
	andriin@fb.com,
	ast@kernel.org,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	horms@kernel.org,
	kafai@fb.com,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu,
	yhs@fb.com
Subject: Re: [PATCH net v3 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Fri, 28 Aug 2026 09:02:12 -0400
Message-ID: <20260828130212.32968-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apGBE3XHKeNohHF1@gmail.com>
References: <apGBE3XHKeNohHF1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> nit: Do you need to zero this string? It will be safely overwritten
> below, no?

Thanks for catching this. That initialization is unnecessary. Would
you prefer a new version for this, or are you okay with keeping it
as-is? I may need a few days before I can send a new version due to an
ongoing email account approval process.

Cen
