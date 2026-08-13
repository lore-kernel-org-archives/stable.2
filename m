Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC27495025
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637786; cv=none; b=rHan/ODXhddWNFr64N4O68FJDysI75i4y6sBovNmIm2mFcttgNjLHOJfVukuhC1TKflmJJLvOsyvw5TG9owzcFJbbzUE7LU/3WEMUyoTkXC/shl+sXPSgIjYhResjerhFvWOi0x/rYdrgrCrtDe+EUkFDrE/B7ReqyLIYiLWzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637786; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fBoztKejbmVfM39BjqW9lUVPhwH+SCq6HxCrEy5Y6B0OAQAe/xEe2b+A+lEYxi8Eo6Q2qoRmxK+82kzo4yz4NQNQm8Y6tUBh9jT1Zw74N5XKCSJCMFRu+zvIWPCK2zEfXpoYwPx3eujpDLYtQpCD36O5J/7Xw0D/JVl1ShfEA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-455ad408573so53996fac.3
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 09:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786637782; x=1787242582;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=aQtAi5HymNp5IQ2mH4//RUgMo0vQeZNFbXwjPAJ+lBQBddGk/63lgS7AWu5J2YV/pS
         91L208Qa1cg2LuNnXlrB0kaHvkhZDtjpRphB8CQCJ/Cw8lgixo84Enl4nWi69xwPh+GL
         kmszH7wkbHI3GdOFMYCqLe2xhUVgRWJ3rs3Wg+E/vcdTr/lSWQ8lGlhQHEr73jg+ctV9
         r69u9lU5+zfu+Mh3oulmiYobakaa1SitdIUcXfHS2w+kMw1IKCmH+TVBxCLcI/JbuUBi
         rHnsh3oyvMmSi4j+qeseljD/eiO6ddhyqRdc5bP9SoG7ejbB6ZAH/jJAjXX7D7RFPfw9
         K7IA==
X-Forwarded-Encrypted: i=1; AHgh+RoOuw7v+xTT6WGjDd/HDT3V4ZFTEVGW5iQxdSuQ6XqHHjhjiCvn3L08fVb35YGTlxOksIb1gHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHl1IjKVOAdmnEdufM7IdT6Vs/HkY/QF1GS/U2CgImWXJyFYn
	BkADEplo6Wfojxsh4MblWVZS6WJdnLAfKE5NxlgNflpi+MDD/ht842pDIiWOHsSdeEoovh9YuWM
	wIZnu699MaNZspPi986WySu7dWifIJS2D4kjhJBknUJVqSFC+EaMP/rakGXQ=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ae7:b0:6a3:d631:b460 with SMTP id
 006d021491bc7-6b0c4355736mr5894410eaf.19.1786637782326; Thu, 13 Aug 2026
 09:16:22 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:16:22 -0700
In-Reply-To: <6a0c8e02.050a0220.3bec29.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7dedd6.bc649fcc.f9e73.014d.GAE@google.com>
Subject: Re: [moderation] KASAN: slab-out-of-bounds Write in hdr_insert_head
From: syzbot <syzbot+45ef5a8d661162757547@syzkaller.appspotmail.com>
To: alhouseenyousef@gmail.com, almaz.alexandrovich@paragon-software.com, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, stable@vger.kernel.org, 
	syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
