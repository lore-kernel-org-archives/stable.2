Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E213F1072;
	Thu, 27 Aug 2026 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868711; cv=none; b=VzjSNS5jOD8g34yvW0THVjeq2u40MD8tVI48QS+AWYAn/lf3rNQtLOFfB7Bq0Gllc4b+xn+YMBYqTGeKHlBwbW/3xo2inJDnc61TMsDk4sgvFIcFn1n3MFKHp6gq5lPnYnm7hDTFI3FPppBBsEE4Nr1F6cfeHTcBWelipUSTt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868711; c=relaxed/simple;
	bh=mBkgzZiTkzfnWoJHWaSXz+J9IHU5F76u8a1Plg3Xa7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iab8n/HhAEMaRMnXbkCG5uf2Kei/YCi35+0DQqG8csAP+0YJuV/WhF6i4n6sEEEX8ewtpvsb10ALBIhyORQKtWVZ8+hF873XUZhtcHUUNm9FxywlE+01/18Cgd+UhUVGclGCEgO0CzWP5wsEm5wjdFBcz0vfgCfkfMzn9g3R+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=QhZl6WKn; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="QhZl6WKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=mBkgzZiTkzfnWoJHWaSXz+J9IHU5F76u8a
	1Plg3Xa7Y=; b=QhZl6WKnN2V5jHNVbEa+N9cAQNtp/9h021Qjstn+VPFDO5FAUA
	LojwIMtxhyZaaAHXUs3t8WyTNUdNdiCAtt2ydpdnxdQ7C7N7jfZh30A8jzXzIAy5
	9zKc79Qc2xxUxMZ4ooA9Fsx92mJnmpxq/iVoOYG4ih78KFUNXIe3q2byg=
Received: from skw.ustc.edu.cn (unknown [211.86.152.107])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgB3fDP5tZBqp6aqAA--.3738S2;
	Fri, 28 Aug 2026 06:11:30 +0800 (CST)
From: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
To: miquel.raynal@bootlin.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Subject: Re: [PATCH net v2] mac802154: fix data race and NULL deref on local->assoc_dev
Date: Fri, 28 Aug 2026 06:11:01 +0800
Message-Id: <20260827221101.884762-1-skwkevin@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <878q5sdj1y.fsf@bootlin.com>
References: <878q5sdj1y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgB3fDP5tZBqp6aqAA--.3738S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4xZFyxJF18tr4fAryxKrg_yoW8tF1fpr
	WY9ws0krn7tr1Ivws5Jw4rJry3uF45Ca43Xr1YqrWY93Z8XF1SvFy2qr1qva4Yvrn7ZFWF
	vrs0v39xCFs0v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_ZwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6MKtUUUUU=
X-CM-SenderInfo: 5vnzyvxylqqzxdloh3xvwfhvlgxou0/

Hi Miquèl,

> Can you justify the choice of a spinlock vs. mutex here? This is an open
> question, not a request for changes.

Both users run in process context (the response handler runs from a
workqueue), so either lock is legal. I used a spinlock because the
critical sections are tiny and never sleep: caching a __le64 address and
flipping the associating bit, or validating a frame, storing a short
address plus a status byte, and completing the waiter. The lock is never
held across wait_for_completion_killable_timeout(), so a sleeping lock
would add nothing.

I also looked at reusing wpan_dev->association_lock rather than adding a
lock. It is not held on either of the two paths involved here
(mac802154_perform_association() and mac802154_process_association_resp()),
and pan.c has several lockdep_assert_held() on it, so widening its scope
to the response path looked like a bigger change than this fix should
carry. Happy to revisit if you would rather see one lock covering both.

> Shouldn't we also make sure that accessing assoc_status/assoc_addr is
> serialized? Typically, I believe the IS_ASSOCIATING bit should be
> cleared earlier in mac802154_perform_association(), just after the
> wait_for_completion call returns ...

You are right. The success path reads assoc_status/assoc_addr after the
wait returns but before clearing the bit, so a second (e.g. malicious)
response accepted in that window can still overwrite them mid-read.

With a debug delay inserted between the wait returning and the result
being read, and a peer that keeps answering the same request with an
increasing short address, the association path reads 0x08f0 right after
the wait and 0x0903 after the delay; 38 further responses were accepted
in between. v3 clears the associating bit and snapshots both fields under
assoc_lock right after the wait returns, and in the same test no response
is accepted in that window and both reads return the same address.

This is also what the scan path already does: mac802154_scan_cleanup_locked()
clears IEEE802154_IS_SCANNING first, "to prevent any further use of the
scan request", and only then replaces and frees the request.

A v3 follows.

Thanks,
Kaiwen

