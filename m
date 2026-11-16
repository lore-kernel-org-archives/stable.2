Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831640;
	b=rJOEP64uXFX1c2gG0bVWfG86qIt/Ds3x2eveL3NwybkFnB+ZVVJmyLgpxfOFPiVG/Z3D
	 MMLdzWMVYLNIIRE3/Tj3c6rVWZ3tqJNa3P27Yo3J+d3Ns+HVH+Tg4ou/ieviB4/Nj5FDU
	 oiONEuLE2ftJGAo/nhlXtc4x5Z05yF31SS9SuXxWcSA9TVTsnW5PLvWrhaZiTBff0scLh
	 nzn2a5ruFQmi5xUP/3Ou8DrsAyB134AjJGzUGT0bw7PPa0XWZHMkTc0XQIVYXvUQ6O6Hx
	 jtv5N6wJsPGPAnZ8fgmf8jhCb6Fuw+Ox5g6g0s+yLu3lHfnLkO9pynrCwFHiMRUB1QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831640;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=4MCroR/sjsq4mO+nQ3f/SHJLqA9hA+O6cA4sBYcKkZg=;
	b=b3uurwu9RNOAARMxLd1DiDihoYLuAF8mEL7VbS07/s/lUBHRUTpmMX5PPGlrjnU2JaiW
	 JOKc549cDgneSamtc3crDlRdxVRQQm0t8hJM/pMeDW7lljLHLgE6pl+B1dOvzz33APMka
	 lmuGHJCpdhGBN9ltRJ5HIESsqqcj/SCYSURgYH3piUJfFaizIo6m3iN2d5R73zaQfBFQh
	 XRC8m2u8odsKRjsVuCekmmGPS7fHeGy99zZsL0KAxh+sjGw012WOpoarAXVewaQ6Ohm8t
	 QvFnfK/pGll4RFcklLVim70hOOSfIfslO2GKrD9xGHdVzExxO3A+mv2n+1zJYz1he4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="nF/UyUSR";
	arc=none smtp.remote-ip=203.205.221.245
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA37606A31C;
	Mon, 16 Nov 2026 12:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nF/UyUSR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794831630; bh=4MCroR/sjsq4mO+nQ3f/SHJLqA9hA+O6cA4sBYcKkZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nF/UyUSR0bYZHL1EW8l3asisTFTPGviv8Eu5gqVRoo59ZrHeswUdya8UcQB1+pJO6
	 lyAxJNB+Op2iDiXD3HFZ4lnBRenC7FvgLLtNFxaTPRTfP1W+GXrG9e4w4MXzRDcGir
	 98O/MkCu6nKj8Qu7abPHlxZ50l5E14RedIKR4bIo=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:2979:aa1c:9ec4:8698])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 5199FA81; Mon, 16 Nov 2026 20:20:25 +0800
X-QQ-mid: xmsmtpt1794831625txwxrqa5i
Message-ID: <tencent_5B7B9ECE9036BE72D331CB2A2E4AEC5F8909@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahMxe7Nis9QgS3xrmsPlhKDX17WXMQD2D8PIOyxhm1Gb53FHXytD
	 4YzNWcq2zfLEL3ipFJGuhhitYhPI+x449ysiTJGcDUJuZaxDIUDAJArVe3MX5CLxEqc03cv6OlHI
	 h2OywKU/9gLYeVck2/zsWvqglFzU8HRH6YtHmafnQQkvaQdFfL0qeEgBK2GCgU+RBMi6wY7S8Pmc
	 iejgiTM7doW4zq4NVdbnSe707CfGZ8u44KMRhci5VXIPDFrpAFtqHUhhAaQlB59HlkBixCoaBeZI
	 6EsSxbZwlZ/E8ebdJjGNSpA0nZCZ/yIOI7ZIv3jGOXh2n3J25ewX0uJNPxdExMN5Nobnk0nqSvR9
	 rGGQ5+utxN+WifW+ZGQyXGeuY3H+78jgTtmhqYeiHB8EFLLIix0jccSKPYbeAjSz1LM70iJtTr/c
	 f86bXmxjKq3K/g/j1Uee6sCMVJYfaKEeagxB3bg7sk37SzlcatPKQvKD8Ac5ZbIRqB+5IwsuAmG9
	 F3smTEFUZOhQ93Bo9Ggrztx+C3YEYKrxEaY93Ootkc3sL91qYHMFwkQJxxp3MetEPm3TYOKEPUZO
	 9lqI/70VxBYW9Y6T3DPY6wynJjV0N473wyveWP44fXnTJopKHKUjwN5ABNtjjju1jDm30kZCy8Xx
	 lpGHle5g5QmIhiWnEdYkbAomPggm2BQJRNjF16krS3W6/u/ClgCKcdRSgSexjoiiekjFuh3owqsO
	 5lWQc5bDj/jaZ6bqPf6mFg+DZqAwJdblrtBuvO/mTygc8M1O9aKZacg7aomeuyAcpHb9uBs+RKyk
	 LV7lOoN9saLS6wdWuml54knc5SghDkQra0etDu81vMA/Hes/KiI6jtE8np7P2Um71SPRAvSkfuwn
	 x+FV9jaQUF89ybMxaxV9UFPC1bL1rLdg/5oQHbAdE28otxHx6sVJ6kfjAFu6Qb0+u/R03kRjgxgq
	 poTep0wR1rXt8uMeMOGdkt53nKZr8ZSm9lpm28SZ6VgekJC15d0j/Ukvj2ioeiutJMsW+RGY+Ke0
	 s+DOceTR8MaxSMsg7lZmAW/TQH2cg06j92Y9ZLWAj66jrMQMz0dyKPLbtah+1re2iqQPbf7LrrKH
	 Xj0wjW
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hang Nan <2122295973@qq.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 2122295973@qq.com
Subject: Re: [PATCH net v4 0/3] mptcp token hash ordering and token 0 lookups
Date: Mon, 16 Nov 2026 20:20:25 +0800
X-OQ-MSGID: <179483162524.42663.16445873285874492835@qq.com>
In-Reply-To: <20261115155747.178858-1-2122295973@qq.com>
References: <20261115155747.178858-1-2122295973@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thanks for the prompt.  Honest answer up front: none of the three patches
has a runtime trigger.  All three are theoretical, and this is what I
should have put in the commit messages.

1/3 net: mptcp: take token lookup references with acquire ordering
   Theoretical.  There is no syzbot report, no KCSAN splat and no
   reproducer.  KCSAN cannot observe this class of defect at all:
   Documentation/dev-tools/kcsan.rst is explicit that watchpoints are
   only set up for plain accesses ("KCSAN never sets up a watchpoint on
   marked accesses") and that "reordering of marked accesses is not
   modeled", and the reordering in question involves a marked refcount
   operation.  On x86-64 there is nothing to observe anyway: both
   variants compile to the same lock cmpxchg.  The evidence is
   instruction-level: on arm64 the CAS becomes CASA
   (88a37c02 cas -> 88e17c43 casa), which I can attach if wanted.  What
   I did confirm is only reachability of the lookup path from the wire
   (mptcp_parse_option() -> subflow_token_join_request() ->
   mptcp_token_get_sock()), which is a static reading, not a runtime
   demonstration of the reordering.

2/3 net: mptcp: reject token 0 in mptcp_token_get_sock()
   Theoretical, and found by static analysis while addressing a review
   comment on 1/3, not by fuzzing.  The crash path I describe
   (subflow_check_req() -> mptcp_pm_announced_has_ssk() walking
   msk->pm.anno_list before mptcp_pm_data_init() has run) is argued from
   code; I have not triggered it and have no stack trace or KASAN
   report for it.  What is verified is the input side: the token is
   copied from the MP_JOIN option without validation, and 0 is never
   assigned to a live connection, so a lookup for 0 relies entirely on
   the two comparisons that cannot distinguish it.

3/3 net: mptcp: verify the token slot in mptcp_token_iter_next()
   Theoretical as well.  Both consumers (mptcp_diag and the userspace
   path manager) are netlink paths that need privileges in the target
   network namespace, so this is not a remote attack surface in the
   first place.

For 2/3 I will add a KUnit case to net/mptcp/token_test.c
(mptcp_token_get_sock(&init_net, 0) must return NULL) in the next
revision, so at least the guard has a regression test.  I am not
reposting only for this message; if reviewers want the above folded into
the cover letter, I will include it with the next respin.

