Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909983;
	b=z+Ix2U7BMEal1NtkKV9EG+kzXaUntlRmAxy6EpJuiezBYam1RirhEgpCaWGgqkt75u9g
	 g86swYQi/H1mNN8naysq4EswwLG0xluT7vhZpF89yF+8HU7JCXQboKRsKP3u3t6goj+BN
	 9RwATrmyp6hmne3RUYFHRznbpYyvG+OEMl014af9MPrsKJRMQAZgIf+CSR19ZOIREu0u4
	 0g1rR3ImkX9iHVSKj99bpAMDtWLlkDE/1e6xTkYJA3aYCxkPpSntVroDjBIZCB8Vf4BGJ
	 Je/pvMzROOXpxQXHQ2aeQFlBJ1QetSZng/vCUftv1W79ejO0ara9sFK2rzJoGNdJOGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rI4LasV5b++IgM0KeqrCTlvPABydB8GrsEj8qvf7nig=;
	b=M+HfOW7u8pnHGQiSBxEQFQSZA0zHIBjx2AaQ8gj4lYuugIyIMXwnmwCbZt8ZfDfzwV+o
	 H1UH4vulIkY9IPZa0GvMRzJ3EXYkggmiuGwG978jeKy+b+wAwF1BGbmaqnBK/2JaiL0lz
	 CjX+5PHRGS7MA3Z3hRka5P7ZZzlc93WFK14ilIIREL7bCv/TZimoT3D2NogqbI3VFKcUL
	 2HcF1ozQQb+Pjyem+0kCZ9dJJ7hBeVCbJigNfIMy+dS/JGlcFxgKkX0jZnzwKXbdQ6nF1
	 TPPCNahnFXYAtfzpPq712EO5bDM1tMlggMcfY/KWxTKuT+uKu32TX/BnhF0fdL7m7qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxv9jBgr;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C61606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C61606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxv9jBgr
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so3721157b3a.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794909982; x=1795514782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rI4LasV5b++IgM0KeqrCTlvPABydB8GrsEj8qvf7nig=;
        b=qxv9jBgrMfukboKyv7rMfU0CRJtV7gusvERDhwg5BfQidZfaSNFmoCgVDYV5+KawKG
         A+g9wnY8xkRgzR8DfqKm1NUUgy4dW5ZvMv9Swp+lsbmwof3PDIO5WNc5xNX3Yc+RZj2f
         LIek1j276h4dfUO8eWmtCxwxgq/rzQGWEPtgUrKKfcKMJS+JoCxutWpyoPOgiDew2p4q
         GMtIrO/Nd83auNzlmLnbH2tBOb9T5ADDVO3R/eS0FcDYiB/alU0NTh6PRI6fqWuErplY
         oi7RigbC+vvQ6godEP3zSZ3YSsKCsfTX1rcImmxv+4/EaKThBRN2B9q2xRkcXtCYbp/3
         L9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794909982; x=1795514782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rI4LasV5b++IgM0KeqrCTlvPABydB8GrsEj8qvf7nig=;
        b=LXKo+/7gkOUHe02+uip+W2qpb9aWqfnOEyhjFoY+3vEAXvqlMNz5xPIvTFy+W9kvBx
         s0ru1B9n/asZgcb20U+NDM+u8yrH4rg5YtRXNGkJAW1TxdgtAJgSiLBb3mYqHvdmMLI9
         pTM3UvIz/MZJA+Irny70tTHjIcFZ/T7KNmcY1anf053YiEtB2q7zMIpDQ/lVNA+A97K6
         5mEK9cRc50//u+GDqLnxJQdbGYKF1lLIXHK84Tw+O7ZrAKtEq9e2mKG5b0Hl2YeiA/mW
         +HDc3bf8SR0xYe7j/hc/CnQHry0M0sNyt10EKEgF6L05xnbTzCco9PFWxBQT68CKudiq
         h6Lw==
X-Forwarded-Encrypted: i=1; AL+hErE3zKagLpmVO+HBa18QP0klnfRNk80pngg/oWqP5MMxz8RktkcLOBrj/F+Clh0teiuC5JgMjGA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6odcI4TJ2vHj6ERMMgbCdvRn++XyIZxKehIbosECEEicsU8+J
	ZyX7dmEkir7YmD9GLqUtjiHj0qrOA028VjGzPB1PT64M3ZSmiAMW43PW8u2UA+4LlraVp3Hu
X-Gm-Gg: AYBFou30u5cZsvBd5e4L7uhqsxwBQARUjZLBhDnCSsMLwS5R1Qf+kgxGaOgidBsqXb8
	B/zrB140IgbqvldTNkg331RLdTTeHamTCNnUQlgnI7Lb7dKMjLvXy61TMIrM8NSMtbvnI/G/J4K
	nJRiuW/XU/Idj0N2f2gFd4mxkbMYZnvI7rgj9F77HDHisv9nVe1ClH0rFNYIRYCM2s9BHlOzB9I
	B9NTXXIgDmzQn6nu+RSs2ihY+PPdYv/LzN+7utIkq1h27sfwc3zetQA8bzuVxJwOsITEKZ+ebbn
	lYGC+qSTfDHvSyyvJnSrXAKzo8Lz3A2TIm5Eyry4E4K65IwNcDom3uDItfR/uk8zEOtbps3X9Su
	gfc2N8M1atvlaXfhrscgYMzHVgrvmkdS/39l/al6ke3X6EAPgw7SHHAc2KIa01qJCC7Rl1C8erU
	+1B95m8i9RGFU/wtPxScg/hmdc8fF09COzYQAFuRBazxn55OPUqkelgFrnulXOy/WqVUG2N3ZAg
	nTUZd45Pt1tovn9WxWsMEZKM+mc/Bnoa6vVftB0/Sd8ts3O46hrhhkbaIlGrtyxigAX+uRdwPY/
	M1yswjg2RfxriQItUTbOkqxCmkO+/wOLN8ilmAguAKxqJuDfBodR8RATbRNpTNxzvBpj/l6YJFP
	rkaDTXRt4WZ+jFjY3uFaanUltPgfdaW2MU1HQhij4teEe2Q/8mIZ9RVUuvSDO92ID7CtuOrwPCN
	DNpXznjSXJQvBiIFMvThjZ422kR1CeRgGWyP4xoGemzOW1J1KG208c9r50hlD8pBw2KAjZc7UDw
	Qq9Y6C0zIiUc9eK31DQ7MBuEOcaPVKkClMpiGwwn3iTehbD2xwF22iUJFoeqlRj
X-Received: by 2002:aa7:9ec2:0:b0:8bf:e028:7864 with SMTP id d2e1a72fcca58-8bfe02879c7mr6741005b3a.0.1794909982190;
        Tue, 17 Nov 2026 02:06:22 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed263b354sm4752612b3a.47.2026.11.17.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:06:21 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory: mark unshare copies dirty to fix MADV_FREE data loss
Date: Tue, 17 Nov 2026 20:36:02 +1030
Message-Id: <20261117100602.797-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
In-Reply-To: <c7c8ba0f-49ff-4b22-bd24-20fc394b1e36@kernel.org>
References: <c7c8ba0f-49ff-4b22-bd24-20fc394b1e36@kernel.org>
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

On Tue, 17 Nov 2026 09:55:24 +0100
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> We should always prefer setting the pte dirty, not the folio, as the latter
> needs atomics.

Will do a v2 with your version, thanks.

> numa_maps does not show any such data. Did you mean smaps_rollup ?

It does, gather_stats() ors the pte bit with folio_test_dirty(). So I
kept it.

> A more future proof solution would be to only allow MADV_FREE if we are the
> exclusive folio owner, checked under folio lock.

Makes sense to me, it kills the whole class instead of one producer at a
time.

One thing though, that takes the folio lock on every folio. Right now a
clean exclusive one doesn't take it at all. If the lock is busy you skip
the folio, so jemalloc freeing a big range would leave some of it
behind.
