Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482344;
	b=IIVLbbGaKrXvhWYSGxDgfK8GJ06MYyCWoEuQx1isHCQYDtzGA7X6XCNWGA8db33OBbsC
	 zygYWSk9aSuKOgSfis0gOH1KJzOIR6TNUCIySN1dvWrPFA/6Txg4QuUTWEhXRa2yPb1CY
	 lGbPeefPxPreNr4X8jwmhVUyarFMRqxlKGpJ1tuglK7hrZW+IOzFwi+9jhnpohjJEqKZK
	 s3p9xGca+gaq3DeF31MKIQ7jq+jlwLP5gBIBuvD07xxLHncfsuPpSZe/uHYXsLnT9MX9o
	 j9eyaXDklqFeZfwjO945mm8O+MvZxdPkmGiMYeFi/VOte6pgI5JFQ7lhiq79+ej+gjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0MDgn22B2Gln4kDn6jyy0QtZqKwhZqAtnn1/NKsmOP8=;
	b=34Dg02vg69ktireiiOvcsVnbf/UeBoo825016sQg85E8lFemZhWgLg0yJtoc8ozp2sLk
	 8wZUPtG53a5wIctv+fEf1A/GOV4hlYAF3097nqEZ8IjVXjqMC53rusHMeyraoxaZr84gr
	 nLniIF40rX+fcZUFjFH1uegh0T/r9Z0wCU+b0krpNp2epHLwVZon9lPmLABIP7HLBj0H/
	 YDhD4K314cAcXZ334S6Gk+tq5ndBu5rsg2t3Yow9R9LErsDKY+EapOcYZ606OUgR2diLz
	 +QUZAuMA+WzqZNp31FwHfJHVotFRu4OS3Idv8KCIOS5/bk6kJ/2JrWXdWto6PsxAU/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4hvmFub;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5A606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C5A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4hvmFub
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcc6094d7fso2336052e87.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792482342; x=1793087142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MDgn22B2Gln4kDn6jyy0QtZqKwhZqAtnn1/NKsmOP8=;
        b=s4hvmFubg/23R7MjICEaX0RocR2izVlBWbQXLheVV3yMxO5xs5fcApUOoYUL5H0VsA
         39kw/f9IEjsNHHvxrQrKN5ZlVZd7p/8vgwc7NvLXcZ4iGjXOyHH7SjzMx8tXeQFxqPOU
         VQknwi0YwUPaWl0aGAKhr+AHJDJju2DaCIS/fdMhGcYgondcaUPlbsAplMhLQX2pW5AP
         +Z2g8iSReQc7aonc1syHO0HKtOIJCs9ACYOOV9PDK7K+ZvhUWC6XbykK+vzinxttypWC
         zS8UweaejF5EJULZyobQ4l96edwqN9U1NemR8C5tMjrO+L0Sy5ez5e2IuKTp9GLF8kdi
         b+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792482342; x=1793087142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MDgn22B2Gln4kDn6jyy0QtZqKwhZqAtnn1/NKsmOP8=;
        b=debzvBuQhrKIU8SHgtwPWPQSICWzUekZpQKgdrNiV0UyPvBDifpJesB4lf3zj4ehcP
         n9/W6oNuC0apLoakUMP/NHLxHzm6NV0/hzjsNWWsvvuvT27VxpUwX05+f+jCp5hCQcRl
         5R/3TXUnMqRX2gFWADjrhPrKwdLJcHwT5TM7NWOzoVNjvb2Gk5JnHWaygqIZgIs+K5fB
         UPJOkTnMzAMZq+sa6DCzM0lIFif3NYzlGTm2gEGyYHiowX7rXOUQC7hMOcLLJNxVacVi
         adRjmIQ233Rl3UWvD+u+s/2OvhG19lTMAlwodcxx26RWqj4vFBla9W5cPrpeO9sXki+l
         uhmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXXDqv5KOLV4M4DaXsXUcYzd5pS3n6tieGtZUjbSrpG1NQBef9I+OSmmA73gGy4Vdo8w2iSCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWdRTSbBFQ9VS/rjm4P7aWcuCcZaEJlrepbZ3SUHSET6NremF/
	sRw96xWovZZhMbHrK5O66UN7zZaLxepoNMQsyiXcBAYmeYA/Sc81Wc/F
X-Gm-Gg: AYBFou2Mb1+gUfvc7g5WRx4ymXJGTO7PKM3+urfn22mWmLSvnsKRSnRCN6KmnZ/BJ5t
	xHGoDYX4T1Q3TWLIVKUTJz+FWUic0cFq8Yd9P6szpNM2SUxMcfBS9t4IHMK8B3oOdmUQlUIZVMd
	HlLvCSK/DFUwq4G+/VGSScCQn1Fc29IWFOjd1S+zagC8ro/cyFOtFCufASQ6IuaIvCZm11csVHq
	gimmeQJ/GPaOJel94TeqyotyQcNsqoBTXDUnI/BI8/Mwr8JKukjl4uNbk35S+JIuo/+6vZVJbul
	d5X8hhfTY9cBfYmWp0WCVdPFPjTs7T9HNssLgmGMqVoiD5dl6M5kDdcJDeQccYkQPDi4UQQwdNc
	1YdXQLH6w8Dg0YAtz91vWkFDCBoJ4q7ruxMOKpLYbbVGFkrpNz1SHh0gZC/jaVrJImirePLJk9z
	VI6+cqcmEtIj6on+a/pWqGee7QgCAxJQ5zHXLyuHD1J5C2PIhL/wNLCLPZPDJ3V5jC2oB9PVTFm
	FxCzeS3um6Gf4svee05
X-Received: by 2002:a05:6512:10d3:b0:5b8:f16f:d4b6 with SMTP id 2adb3069b0e04-5be50a79196mr3315671e87.39.1792482342024;
        Tue, 20 Oct 2026 00:45:42 -0700 (PDT)
Received: from grower.astralinux.ru ([38.74.72.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42abf1sm2466787e87.19.2026.10.20.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:45:40 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: alexevgmart@gmail.com
Cc: co+0ea1ac045375cf05@bugs.sh,
	davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH 5.10/5.15/6.1/6.6] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
Date: Tue, 20 Oct 2026 10:45:33 +0300
Message-ID: <20261020074534.277692-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012163331.45783-1-alexevgmart@gmail.com>
References: <20261012163331.45783-1-alexevgmart@gmail.com>
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

just a friendly reminder
