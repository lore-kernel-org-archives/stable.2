Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202958;
	b=vI73jptdRyQU9SZsVbNIGKY8l7fyapwoVDmdlS72xXibFeFBmpu4PSClF4PRTA3OUNAE
	 HqoK1Otf5Cxe0m9FDA1u9GITwT9wroluC97ZkSX+gqwjxI7AatU+vyjKu01Zz0i2nBlU6
	 A4icj367IsszvfRYvjnw8uSOJjT7k+q8azk+0WbDzv8whzaonk5KxMrgYLQDFMLqQ0kZh
	 7nuCrtPRSZd+qc8AxgfcWJT+nIxSQZ4RStoRbKLgh78XFIU5+F4aGlrn/yXGonqoJF7CZ
	 Id3EiVH6JwUa4nCdtIViNayfVrU59cc6EyGIEu9lo4xd5ShWYRaQD7TA6UQ1MRe8NTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
	b=Z0NULaHjcLvw/VOaaTRDQU7g2jiD8PyrZm3ZHwrvR/WIP1F6wX5P4w0wIbOMMw0SOD1t
	 uWCYw3APjLIZEixqxz4CHTN0gLk5vfSR4uW/MJOrHEGsFc+jsmO8F9+L+50jjiVl9IBUm
	 N6g12vN6obePd5lBcvIn6pgolZl3j5kIrrsGq+O0CC7FFieGMFNiPycSe7OdTxY5XbNFB
	 i5fi3p6PSqZIN0tb31uvekKG7KUsdfLEUL5cG0aRAQQ5MdsEriCxXeE2UoqpABpELHRfl
	 91tCmoYeRZUlqWF6YWd8IsSyZ+99yBxqjzJz1JGyqT2i9eYKhcKXJJWRNAgiIDeENlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="halrdo3/";
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC705606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC705606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=halrdo3/
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so4260365ad.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202957; x=1793807757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
        b=halrdo3/n/6UlHBrM3qN3fciZKUoKF3rXjRzZCpuQz0IgnC0ke3WUITCU3zLXQD0k6
         VcWV/SvMk3WSY3GARWVABDTTh8UENPJ87jPojKjvHfN2JnCdDY8AK1XDZU5tYc+bn1/1
         U4xCZMBmxL2ZnTIlnr6S8zOZ24GXcuMR9SVnLr2EdKRUce/KKzZKmsbT78R508Xgmnup
         fQYTiiTGpkYaP7dlEv/BGg5+mD/Yv3/t8b21SEvfXwx3UqaO2bucwt7qA/l2hVDXILxp
         E03WprrGmeSxfCE7bHzrf5XcS4mzY3X5qew1mW2HBmp49Bl90wJ/RH0k3owYEUODLskc
         LpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202957; x=1793807757;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
        b=PCA0vvql5fd4rqohcUXZNtGmmdYcNSnGfMGdyzSxSVAgXJtPJIHm8dPg0u9k9A1b0b
         D8C7+BSLiOqFLgrhq1xUxWIIE7KXBO7WER1/UhFfbNUJ/3tUTUHI78VDXH7dOGo4l6Oe
         4N969TTZuq4cjl1TRsV0B2swNSafmGbbrs8+yjEsXl53EcqDhNEk0Znz79ll6E1fGBwj
         +5Fx2H3LvvJ4Eyf9/yYBnEBUDDoEEJ4ErPZqwJholgvA+COGhh+RfqifTxoeamqyzhbh
         3RhZE0hsOc5ssGhVa0CAMIMpJOPZj4wQT8/DgQcpQF/5ZrqMKOFjUhmAUlDES6ISrUO/
         2yDg==
X-Forwarded-Encrypted: i=1; AKwUvBzYQ6AHd7rphJBf9EzZuuVs72VmB6HpzeYc0MDT96+d9JbFd8c/u6mgqyDsYoF7q6VDXiX6p+I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOPdVvitNVNqB/Ob+8iAGx6IIhV3yvIixFbtCFLj0fXJLjuJST
	UHQ5jptu7JdXtuathvPjUfGqejIRH0zKVCU92/mgRt/yy1uMaH9iBuZ+
X-Gm-Gg: AYBFou2XprxXxGiBaPFWZonHolvG9jDlPKct0AwDxmzwZtarBqd6UXBq+EO8fsGPHAk
	vM3ABHZPumyEXYMYCGxuUt/9CM8lnU4PmKdw5TCHvtvApcWMZT0RUVmp/+pq0OVKyjgIJ/8idXq
	QYf6ILoqunpUWxnXxR6i0ZwPHt2uQRELdjEsqmweewTc0DFbgwiP3xhmmJXBykmG8JFnjUoqMJK
	vgnJwGVNOdm0mT/MR4O2NBaXrfaxbCm7Eve6hgux7p/tFfeaGejDE18I2Bj/smVg3GVy2yCUpTg
	yPdzBODGJDLtI0oL+dMReQpQv/kjbHVdCs7xUsWtK04CgZT8qHylOrEIC1V5InAQ0VdxAMjZP0t
	s2t40CRoPHtdKnj3rqLolz7KpBe4aWjLkTnDWwySN1r4eRas6nSSFbCJgrHmyGJYWg+PsWPIRzl
	XeFLriBJw8esFhE+C8f+pyRVqBiIALYhigrwxLW9txmtQMTTHkbYD/089C1gMrCdrLmVqwHKW4N
	hfbJyAL9BUsTi7U04XmQB6cXVlaw9tq669VXck9EbfhhAQkpR0f8a44NvfYb2+fjnWQtVMnPY65
	wRNLla4peoK/fkEb1hs+7GwwH7WGvN5EJFwKt2p98ajoxbTPFCHwFD1ugwlvjwcPP3czloOZ9A=
	=
X-Received: by 2002:a17:903:b06:b0:2e9:4175:307a with SMTP id d9443c01a7336-2eb003b2d19mr26567435ad.22.1793202956855;
        Wed, 28 Oct 2026 08:55:56 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:1490:f0fa:6df7:f234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b77e2csm23700275ad.19.2026.10.28.08.55.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 08:55:55 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Wed, 28 Oct 2026 23:55:44 +0800
Message-Id: <20261028155544.12908-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auH2yISa8xouAx/3@boxer>
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-3-testwrzwrz@gmail.com> <auH2yISa8xouAx/3@boxer>
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

Hi Maciej,

Thanks for the review and for the Reviewed-by on 1/2.

> nit: breaking RCT - I know it's test but Stan payed attention to keeping
> the order...

Fixed in v4. The declaration block now follows the width order used in this
file:

	struct xsk_tx_metadata *meta;
	struct xdp_desc *tx_desc;
	struct udphdr *udph;
	struct ethhdr *eth;
	struct iphdr *iph;
	u16 first_len;
	u16 pkt_len;
	u8 pkt[256];
	u32 offset;
	void *data;
	__u32 idx;
	u32 addr;
	int ret;
	u32 i;

> would it be worth exercising this up to MAX_SKB_FRAGS ?
> then instead of having this flat layout you would loop over the desc
> count.

Good point. I changed it to loop over the descriptor count and exercise 1,
2, and MAX_SKB_FRAGS + 1 (18) frames. The extra frame is the linear head;
the remaining MAX_SKB_FRAGS frames are skb frags, matching the copy-mode
limit documented in af_xdp.rst. The last descriptor takes the remaining
length so the fragments cannot overrun pkt_len. The updated selftest passes.

I'll send v4 as a new thread.

Thanks,
Rongzheng
