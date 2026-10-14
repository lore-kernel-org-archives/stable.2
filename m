Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E873ABD90
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958352; cv=none; b=BdVkaVtlmQ8HVDYTvWsU4ABUpq1yBegZST03+ItC7zzmhomXZ/wvS6U+U7YBpSngP+T9b7EI86/pIyqQ0hgUhs3T2k4nn9T/4J4XGkU6L45t0gdGyTeqaQeBD2MZbvNPT1xmKJxWzZlAPDsn9kHQmeP/tuKwGCS+eIJibv3KzZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958352; c=relaxed/simple;
	bh=ZZ8YhT4vttbyAReWLwDYCcZjAsPCyQJ43qms/rc9dOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jx96kazU7W3kOYTWXYsN/6QmIqBBWGyaPu3hYDIw22VTrhtth3TrFjGdlukOLRjBTPRiqRZ3muzXF7MSsutSMrlBHm/xJcfasSlDtG4HkvOjeheapa2emKGBR+IrJRKV4X+tQKpAddnmrkULQYpfzNicocmCfx+Z9tXooQxCPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIoTe7H6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIoTe7H6"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so2789319a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791958351; x=1792563151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZ8YhT4vttbyAReWLwDYCcZjAsPCyQJ43qms/rc9dOc=;
        b=iIoTe7H6VgKDcV2LZdG9OjmajV6SAJRxiL7dJG5U5TxMocbvVjrhJR5fn9JMHUTB0H
         8namQtdnWK/sIHrfpaSJHw9nCHeAucd6RHYBXcVuxh2Mg87OXAEMcFPIdjPcjF+CA2+2
         xbMO9K33WqQz+2skTzrlpNIL4MYIvZnzM8Q4I3qM7bzU5OTiU+c8+OEzJUr9BcknOxS0
         lodKTX+mBpDan2FoS3LWR9xMqxKxwtd3i+zkhYFrqDf1NkIeTYkILD3pxxZJzUtGRgiV
         G2JF3zFnjl46mhxJeVJtxVoY4n2Ud6z/1GgiR/l5ecL2t+1siAlwEGJ/imvRfvU49lwT
         EVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958351; x=1792563151;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZ8YhT4vttbyAReWLwDYCcZjAsPCyQJ43qms/rc9dOc=;
        b=a24y8soZB/YCLM10bI1m+lA9PKV52hdtVjQBnCa28/yJVJwrOQOpqPUAvAcj/ZQVlX
         JtATmaplRq6ZaI4epr/cufUhqvD86HtUdKH4eB+fNw+dEl5VWVAXmJeHhJHJfvqbVUQB
         BtNheVVNAO4JgUmwjSdE+k50eSJGS/KyLER6XsoCTPi/lLxrh0JKcHOK6sHtWWwBnw9s
         kZ2h18z+0FSYFOjQzxN09UD3rsinVJ2mqRsSNngL1PC/+9X7sfTMgRPw78CDe9l8fuh4
         nb8P8GBxtZZA44YTMANiN1k41+scJovsJxxQfQBSIybnS8hvyFVIUgue4j5a0ddV/TCH
         8P+A==
X-Forwarded-Encrypted: i=1; AKwUvBx7QzcmsrOlareMTPruQ4fd0A9EUInpAXvIpyHEaQbj2sudeNJHetMdUAnptD333efSjwnIhHI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYZttgGI5X+MtN2HAJdDbHN1BRSzq5NaRu5o39b7xu/x6d+5TF
	ejewMEQD2wffgPUiCyRx34GqyUYWqdI/Yf1J7DR1hknNGsUMvoaT/8AKBCTEkQ==
X-Gm-Gg: AYBFou0BcyYFKr/vmSRlcu4/PLAQrAIL2IUN4x9tx8fxmdxd42MBXjyGpYOguWjBrFT
	6UiT7KvlklG0pImrQOeZLh+oD325JNtyjGJMjIDbEbxdWGEE8baOzSzxEQNcSwR9eHDoDAMwNvk
	i0q0GnbhzqPa6nM9iL16fBPhw8zIUysHnFloXIqwdKk54vT+OyupYThTxrsg7SlmrEMCtRYPkqt
	XurHkDLxgXB7TOTs/Pog8+/4BuQNXWMFAIBtwOlxrOB4U8ccLuDrXvJVqn2eOj266hdxQGHVGa9
	B1bVhodSgbppz1gTZiItWfaX+QiimOzl5uT8qt7IjCPmGdSK2YnwyJ/lrqBqX8OE9zin/P9xYDC
	KeiAySbM5hHSSCnNRCEmLZNNDhjx2jOGAqTMZ+YzJqZSxY2hCESffaM+YSeA0JyH6MSkxWQQWpU
	8aM2a6e5rF/hB+wX447rtqVZ5+tuYFqDjN7scrdKq32dP+G/Qj0zRvBKtRMz6vmDzgpZGVuUjam
	uFQOC2lhAEgAtbRzxtCLjD8U9FNgDwpqArbclP43CY=
X-Received: by 2002:a17:90b:1e41:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3ab3a96ffd7mr13125588a91.59.1791958350750;
        Tue, 13 Oct 2026 23:12:30 -0700 (PDT)
Received: from DESKTOP-0UATUKF.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f04e324sm3094613a91.2.2026.10.13.23.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:12:30 -0700 (PDT)
From: Dongliang Qin <cccccccccccc777777@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Dongliang Qin <cccccccccccc777777@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bob Pearson <rpearsonhpe@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] RDMA/rxe: Fix MW/MR lifetime races
Date: Wed, 14 Oct 2026 14:12:23 +0800
Message-ID: <20261014061223.1547823-1-cccccccccccc777777@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928171756.3254016-1-cccccccccccc777777@gmail.com>
References: <20260928171756.3254016-1-cccccccccccc777777@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Any comments on this patch ?
