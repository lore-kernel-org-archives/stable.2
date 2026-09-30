Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F741D22A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752985; cv=none; b=E8AITfyK2f8MSOGC8/Q6Oc/oc95iaSHTn8J8nImOX/slQ3JJvb4xKNl9Ocpo8icNulhK16tOD/hmFnuWjmQeJYRMjKykQcNnF3cRcebH3tVMJOUbRn5oX3t2yrXptcA9yYQ3hxVcwJqGEtSvAzK/PCWGBu9ExaYBtIjJvXB1bJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752985; c=relaxed/simple;
	bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTGqHizW9jl5jG/+2Yw210HgAeCGIMH1S0rEAX4mK/N0qWfR+0bp74iJm8ihueXuRg+i44NsJKbe+7pFh1Zy7VK1zghDHJ7gr2IO7gCPiXN4RF4Y6Lq1FnZfVi3jggxWe3WJgbQ7P93kNit1DGe7hef30jD6NPaYakp13X9MLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVuIBfP1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVuIBfP1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39647184c73so1008912a91.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752983; x=1791357783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
        b=PVuIBfP1Hkj0GNMbPlHeYSE/ADA0psq9TJpm1sHfqZcx5fUaNTVNAtHLsq+vQxsxzo
         XGoLyAlYfJd7xxh9jBlLLPvhm0kgXhnBLSh8WBvve3l6BdOyRoz/B2qs8QYn0NUdIaIW
         210iHvRxDyLnl63CSfDNQG/jSEjhYq4TEWsL19jHTiQxOfu19rl72B74p53CIINHOk6G
         hHUSifOS3PLhqUTTJZ4mBM3AK7W0TwQL/pFdd5rA4Y9N8RD84zu05YmxfKWw1W9Azc7S
         QbcN9uRZxppsjU84AbY8B6QexNqoji4NU9zCz0itPKKIeXgI9jemKofJBTRTYbGNzIFM
         ufjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752983; x=1791357783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
        b=v4ynxvQpVnJE9q3vkG22qeDw1cOZOH40hbnhKaR0xTB8vJhCGR5m2WEpjtRllzWNQM
         SgnVx1PTOFpMMBfIM7K0pyXozqaKbnFSYBnE6ETanE4os5KrvKyJpK5BGfnNFJpjvA2M
         /Js0tPCYYVrQpst6Y44V67CCOEIU1cx1nctAK7wmWr7/BoA8hAI0543bDUVjvNLXrjKl
         F7wiBwgc7x5hHn9lmOqh8lMQtfgO3gvZ6io+7ngl/ZxipNnzsphWXTid2zGgQqkCEvbj
         21yAX3CVuJo9Xy8yzhNpSycBTpq0n7AvGdIo+AvkukB1cqC7onyS9iIacCPWRMmOa0cB
         aBDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEE9eUSTop9ixBLZJEd67JneG+ECp6FTSjjZ9Y8XfduNmY1N/ybKnB0uYli0/mKmbp/G4LWds=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjRRvFIUo1dx7GRj6GFQcAjaze/q9KxSpo87kHhY0XKZ6R0QT/
	EAPAfBKnmXjihw7jy6MWYR7e7qnGWtfC0ZZiNQ5ioMPJciGxTBxAej9l
X-Gm-Gg: AYBFou2af44+wBQZbYv1u+bXck8WkwGKAoZkvRfMn09HtpQl2ehN3UQm9cZKpBiASk+
	7HMQnYM1XdPcONDMaw7XBJfK9eJOCqwUy7a35EnhXSa0Ifbyy42XJ0WcQ57Ghe0DwW4nK9d14HE
	+/Vl8BQcLn/CpwSJISVgvGDPowQO1y9irrDH0ltPnjsAzC4107bn2r8VQJ335EJ1ZiYyIeSak5E
	9MEMNK31zuF78uecqoOP2dyy5WBwfj2KCbItXPOhNVRm+3iVm0ueb7opiUNo//HwjdO3OER3oZe
	WrHKhoQEmcbCDYPQEjAw++Q9bJ/p/p5uBlTlDgK7qFpsmrYhztncGTGvB6dPsIgC9pLY44Mm/M/
	8QGC4T5iWzZcZ3RwXX+9vzftJdA1CqruqjXJegWZZcRtuW+A+DtSZvdME7rzW5u6Czuj+T3W8AZ
	atTTbyF5Qt5dBGXFhUcyarIM+SeRY2l+nfycJYJ7O98c08desh42wu+cjroSNocVEOctJpPj8Oz
	T+G3aDB4VgZ1JW5ZjPt3Z8iASc8WOnZd5qHVfsntgbzKIRi8tuG8SlAEbPizIaqV0ZdZTeplYVL
	SUQ3O2WtUXKdLGa+X25SQTNzcNp2xSO+75Y7+yxfRalM5uoutra52moPX1I=
X-Received: by 2002:a17:90a:fc45:b0:3a4:cbb2:f35c with SMTP id 98e67ed59e1d1-3a4d13a690bmr382719a91.22.1790752983099;
        Wed, 30 Sep 2026 00:23:03 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da14e8c5sm345460a12.12.2026.09.30.00.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:23:02 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 15:22:59 +0800
Message-ID: <20260930072259.1167895-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-7-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com> <20260930031604.70544-7-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to the cover letter.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
