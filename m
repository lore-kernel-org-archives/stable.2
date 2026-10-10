Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63973101D8
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602257; cv=none; b=JzGtiqftigfy5OfYo0MElUR6aOq0neE6smstC4o1x8KCYxQY3G0S4zYe/qU+O9fswu9zJpqR7K0FnM6NOCSaKXY5hwSbwqPLlaDZ9U2ovMDs58dI3ybfGUscVWqs0idH0vMApfKXwQMmiuq5dw9R5j33zHPgCJ4EL8yCvbPAkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602257; c=relaxed/simple;
	bh=fkIQc2cBRsR9esk5rJ4DOFEeLxYdmg2udexU0q42DCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfXeCu1/7qjQUTBXXAxCMu25FgiOzlIPJqxnJ6PygfqtDZRPTdYiZ21mrxN71x/BSWe9hD42ePpC92jDqdBzDubTbhUIofdK2fyFtM1tEZyM7a6Uw0r+/Cg43j76SDQr6RSgRMKIdEOIXlU+Y5+AJ3EhKb1i39bMCLVPrU/xueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFjeLbh4; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFjeLbh4"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-353804b591eso538804eec.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791602256; x=1792207056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fkIQc2cBRsR9esk5rJ4DOFEeLxYdmg2udexU0q42DCE=;
        b=SFjeLbh44TczITHEjC1J7EQQsj2voyKadJ8MTJE7hH8I/dq+RzFBOHDbuUreZ+l3hu
         4YP0dY96HBaN7OPq91LGx6djAJ3vW4uMOnmyOkhbn0DlgZnTOfwc3kMMeqqZoVwlRHuu
         mht1cA1+pGtJpx9QkrQUsOsb/ZVJA/Z1Z/97yeyIL+7v8IT2hbcbLSqbfN9RLZ1NMhBa
         dnEbc+WPMeJUhw/Kgzux36UibFbrkY0gNnzx+9CcdseyKIHT798WoUJcDky4SqCWzmZB
         6vFjnkXHjNNMEz9H29/K/uMBHdmF6PjGoVlUyJTiIjq4ujs2kzs/ZEZFqyoy5RNirNvo
         VzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602256; x=1792207056;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkIQc2cBRsR9esk5rJ4DOFEeLxYdmg2udexU0q42DCE=;
        b=vIjkDKJOQC66nd1pxjuOEQISZsWxo0JqhloYZCF7ukYbJjUboRZYzYk22h8fk9zmaG
         GlrWWQ2Pcu8UPGJKxm85zhEdmj8mX55GVvS0ydVSKxnkm0GHcXWh8CYUZKfsqmbWgmIL
         sc/4vMupkcttYXJBg97YPmIakzDXcI049HjRVfwfk0XE63oF0cGbEekJgY79H4fEnBjv
         cys9/yZ4HJoHiDhM+cDUi3AZqSJyFoYYSxiGJuX564SJ9OwSl03zdHVXZHypfeWb1x6z
         q9pL77CbjsVjNZGZ+QJ+9VpY3KBL8C+Bytkco6GHYDgZOho/zm4wBcgS29Dd8A6C7Jl4
         BlMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOHVoSk22P+89HFs1treFjd2Wm2tlccxSdXksE/vygfmAWs6H7zs7HVdsBriQfbGMZ/tK1ico=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuSAO9u9yAG534AArhkZRudUwn5cYesvfcwGDuAPWj3vQjhZx+
	UdEZ1PICyb+98nI0vJc4vMfb1Ci/xSYCBaAcs82e/HRGRZjqVFOwoJlX
X-Gm-Gg: AYBFou39dD2CGny0v7c6L9ZCLt3yGeNX5q0FlpLvZdxBFmzOTlinkN9ESobID0wz5QO
	83S7o+qix5qLJ5PHVjK1TNC8jV6VywnIqPSnbbWc22NYUpBpz5FJMz1rAJE4KyqsnzRMMyMdaaP
	mhtodI2o/y8GqZhsGCLmhJP7j1QrPHd2imidwgDj9VHaMuVDL/0XqPPT/P/BNMwBrpB3XeHgTon
	vM/nK/heNCKN7wZ7xke09Q7nXDKgv9sfuhkjyxJhG8PTbW+OguQxf4tcGPgGSvtVOaQlcCO20Gs
	i4yWpFixd82YAfsm3EOm76kDeEaD2SrylC72re4tGWdCb83BrO4acjznSDVV6ctbD84YrhRQQRv
	K4yPNL1XfIMUf+ZdWmKd69l7N3bao+mclnk9dXmn3OuyFC+/DG5+3l+DWilghRQjkSO5dyPqIhS
	Fr6rKYZIHpo6U21QGiUY9S4u82HpV236trSPio0Y38TBjLDHESORntWGDOrCajiQ==
X-Received: by 2002:a05:7300:c7c4:b0:353:7b29:54ec with SMTP id 5a478bee46e88-3537e2d8ec8mr4879682eec.40.1791602255846;
        Fri, 09 Oct 2026 20:17:35 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm10654296eec.10.2026.10.09.20.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:17:35 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: don't quiesce the queue when setting the default elevator
Date: Sat, 10 Oct 2026 11:17:30 +0800
Message-ID: <20261010031731.3882546-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010023608.3667184-1-odys.yuan@gmail.com>
References: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com> <20261010023608.3667184-1-odys.yuan@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ming,

The patch and my ping went to your Red Hat address, which I think you
no longer use, so adding your current one. The patch is here:

https://lore.kernel.org/r/20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com

Thanks,
Qiliang
