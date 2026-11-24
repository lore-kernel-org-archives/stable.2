Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523928;
	b=Wt951wY/S0AP07qWJSBifHAMtNw5jgpW74oQlyDdX1YlEIErU0jcNIts6jM/VAxUpfMt
	 qXZF0eUXtf+fdBAuj8TYeRk5W8vr7ojmQf1bSMpCz59++f4RcJL4QBNRKi/aSf54LL/M5
	 9MUiAnSrmTeu9Jy4oUo7WanpYj+MUzF2thPe/8zQ+q166aBr1LTvRcBU5BrSyGe80K55c
	 D+guVzUm0GJls/MWPfzpzN260GEq0lHJhAOjmXsmCbRjjAGBlS1wzhfmBv5FjoR98kJGL
	 Au0Er1IA2q0LJ13lb4DjflslFbLTiOiyz5ga++GByItlCEEB3wU26ciQAx6Dwm3t5lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523928;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lQg8P6M+1Ns5pg8gHQ8BUz0UsRavw+1ltXtTQ0T2Dvc=;
	b=r6sEuvT/OSXNHzdVOHTX6FeNXex5q17799bCDbwaPKgeKmpCdQFSqnFtb8nzGhtZYJMa
	 tZJy7RkJvNGEyoAXt6hOtmfuxUmKMSo0J9npfiabMypssZyuxs+rjn0/owriuU6ZXjxOP
	 QIzdi6WwSf5t3oX4xz5NUkIqCVWws/oUhHVrxZT/6o+ewyTmEHP0P8+3LyK7dQRl4S/iO
	 eZl8E2c+yiETrfOpaEzqstPjhE+z1KkB6aJsGYN7bBa/3BZrU3Bf33ARdX6BB/Hp9jg+R
	 FUQw5a/OfZKfdmna8JZHam+BA7vx4OuQXhDUoftNY/Y7s7jRfRcpsC3MeDxGZFI6e+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NqdEuoDD;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IOxE1u36;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46633606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46633606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NqdEuoDD;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IOxE1u36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795523927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQg8P6M+1Ns5pg8gHQ8BUz0UsRavw+1ltXtTQ0T2Dvc=;
	b=NqdEuoDDgyUTMuys/5P1Ww3F30mhK+OCFg/CdBpfSCrgsL3iRowXUlzDBZF0g0sme9qD+u
	3hZfXj8fCNn7SoznN9DhBYStmiKw6Ayevqs5CADefv6H4OOwSWXh8Xs4QfULjfwoaUCo0H
	wcKKLo36+JW8SnaaKfNEg6u5YEsPVhQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-FS7S6jv1MZei92bDz71LCw-1; Tue, 24 Nov 2026 12:38:45 +0000
X-MC-Unique: FS7S6jv1MZei92bDz71LCw-1
X-Mimecast-MFC-AGG-ID: FS7S6jv1MZei92bDz71LCw_1795523925
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-949b0d3232fso650916485a.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795523925; x=1796128725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQg8P6M+1Ns5pg8gHQ8BUz0UsRavw+1ltXtTQ0T2Dvc=;
        b=IOxE1u36w1N+ZtI9B4Hp0VNy2P81WVK5H4FNlqhsVOwTe/nAWJL4trWr+9Th3I77jU
         OcArGwFja6kK/JZrNV+940VtMnfkCYdIIWWhHMKKSOXOql7kcGKXzvoQ/FqI5uesIGGa
         Z6azChhS4NGI4iZT5xfyGV/YFZB4bdLFckzCd3KbqNeBUz2ijwj/l0OUKqEO/mgBKaF5
         VCbSGALMEETO0QwJztDt+5uQNhS2xNHXKrO9sZE270DOS42UEb7Meypc8s2ddcTGSTbb
         Gq9R3WTnbtFw1NsF3G6fzJzwfKz5J4CiuV6p5PHbywfaWi3PFZnVxr1l0O8INoUTkyKa
         ihjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795523925; x=1796128725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQg8P6M+1Ns5pg8gHQ8BUz0UsRavw+1ltXtTQ0T2Dvc=;
        b=f64UqeLl8tT/U5YYaObhOJTOouvIoKjPC0xF2DCjLGRLYqJeZJpYQhm71Ul+WReOOK
         U6Sb9s5MuKN46H4Xj/UvREQ7AcqEnaWx68P8xDG/13gNk1PL42pj5zpndSrbuQKCLs7h
         jk3G88jlddtY0+yVPV0NJjci5gnYxyKl3wxIt3NrJCIDYyNuEmadBKj4aJwT1Mkkjw+r
         2942hoqInIP5rt6S24bbPeeyNw6nikg5ebTD0gqOELvVHzQfvpnmHi7iCvGJ81p/PGKg
         RZrb/hWQp3WHzZn8FeMFxkY6hPFct+elzRu6uIEOLUqmetquaBFPLAzqyeC7jJ0spaX1
         IUIA==
X-Forwarded-Encrypted: i=1; AL+hErFLugARove/ZH7QSUP1/K54jjRISgz65qRyZZl7dadEG9xGNH9SzknGi6bdHItSQpRzdb3cwjw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9q2M5BcD67aiZcay/jDGu37dh0DvWc5nG3TkMmvWqvS/YM5FOd
	AXxCIil7UNpaYR05NKn94h1VmEMJbRbSnxJHjU5DNXOXNDtWxCSnoE6qUXvTu3cTKNGtXt9ZB74
	iargkBgy+sxJuOpNxjcdbGjs1JrMwvWdFd0xgGsgQVMM1EVcNz2MtbhZZKQ==
X-Gm-Gg: AZFdTZeRBzUq+bxDDT+ZTqZfWq1DRLc3++ef+gdbANB9UCv2PbAsACbEEC+a9Z7lBWo
	mCa+HtF3qkW4orZC+7D6sDeQs+Ux9khlg3s5Ji1H3Gg+f2cnklJURR1uZ3JbzGEYQ7fQoQbQS5N
	ojuKUDYcKrO9tlMZyWpwUYURadFufQ4ko1j9nQqroNV41y9s+ya67haSL7VjHaWlb7voQvv+ABr
	JQ/RO0ECyC9dqf3mQsxbmSUl2rQfqduNX6aIfegDgMfYOGPCWOEZrR8yQoU8R+3YbLA2TEbIX4y
	MpaBq7m8TjJlpjkZKOih0OYruLfF/4e7xkyAUJg1m/OUI0CZjlp+PtNEZRjs4KbQNSGF0qeXog2
	XeNkLWBHCavEOlMiyC7yfr1nXhS+saSMPwP3inf/qnTrbBPQK9ZFzp3yW8Nj2phX6aA+CE6Vdml
	QIA31dcllyKEEBfQ8SIWKzAV8L22m+6zyfoTzWvgT1rcOraMTP2AncWbOzi9ia7AOYnrT/Ifv6q
	DhjgJ6kp6Nhn24lot/vns0HhYD0e64IAgcCNHIS1WA7j9B6g2xF
X-Received: by 2002:a05:620a:40cd:b0:949:73f3:83d with SMTP id af79cd13be357-949ba9c6cf7mr2672201885a.20.1795523925023;
        Tue, 24 Nov 2026 04:38:45 -0800 (PST)
X-Received: by 2002:a05:620a:40cd:b0:949:73f3:83d with SMTP id af79cd13be357-949ba9c6cf7mr2672198085a.20.1795523924616;
        Tue, 24 Nov 2026 04:38:44 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb349db3sm1019872285a.7.2026.11.24.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:38:44 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Milind Changire <mchangir@redhat.com>
Cc: security@kernel.org,
	Quinn Grant <leograntquinn@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ceph: reject MDS dentry names longer than NAME_MAX
Date: Tue, 24 Nov 2026 12:38:41 +0000
Message-Id: <20261124123841.2142828-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120-ceph-readdir-name-max-v1-1-ba7c434d4733@clyso.com>
References: <20261120-ceph-readdir-name-max-v1-1-ba7c434d4733@clyso.com>
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

Hi Xiubo,

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

