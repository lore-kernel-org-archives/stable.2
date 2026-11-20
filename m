Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177091;
	b=ook8TpG0L2WK/gvXmc9F5Kt/ZTrjQur4VZepQj6PKxHiOQRtyL/4NEewdVVEYsBaaZY0
	 g37ec6U0l0vAogDl2oRWT6t95a1X6sgwLujZ5Ic1Xa+Jx6SQXr3Pqg1SBFJGwOfQ3CaBP
	 NwMYI0JawgJ4mFKbSxFEuZ5f5MAXgL+khusmlgYmQIZDnhp2mcHQ5YZ4PY3flqOb0cw36
	 bBgKTe0PqTNbb4ou0s+jpbN/9ps0ZYWk2dxq/hwgmYmtHwDab06bYgPGq9MI/0OBN0yvn
	 Bt9gaOopmV8RgwRjere491e75WX8gXMBK3nFFb6npCJ5vo1Rr/E/RPXCM4A1g4buqcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177091;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=bMm8H+yvAuVuYABF/zltzdQZ92nZTYXGeyLMpgEqP9U=;
	b=XMOdaASS2qTFjTDkQ/pPlISYCLLRsGwIU0PHn3+VGLV585nJ+qkj70K062NiNe1pSZqH
	 zHyC4TkizjS3b27yOKT30Rt3b0aiC6XhWw2QdXmCIqFS+PlMim0Jp7v5IyabIRdMbu6Hy
	 JuuHdxdZaDtkR9AzfQJvGw0Ruz3TidtN373RTfr4UNfhs1pW267M2ncqgcI91NLuPCT3r
	 SL76lp58T4E6K0p8VrgtgfP41NqIijWrK1S6cENW57vFSzcS4cBtyATVT5gz95oYOP7t1
	 oN7nTnIsfrdGeznVFt7FjyaFi4uOWpu6kjBwKsX0tnJ47xlPFvta8qKMzOcoPoa4BwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="IoQlr+/t";
	arc=none smtp.remote-ip=203.205.221.209
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CB606A320;
	Fri, 20 Nov 2026 12:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846CB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IoQlr+/t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795177081; bh=bMm8H+yvAuVuYABF/zltzdQZ92nZTYXGeyLMpgEqP9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IoQlr+/tU+IsIFdlXvM3yq8cxvYY0tpwZPbsNEaHerUHDkUdK6K6sagyb9g/v0nMb
	 IP262ZyD0zVnPw0fSokbQPlFU/8bJ24/GzGa911tt7aVVoYaRY3q6nt6xyFvANNR2t
	 Q/0d1+crRDcCXRZ1nFUcM7+5H9dYXhDG372uCnus=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:65c9:1ea4:b234:d5d4])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 47914255; Fri, 20 Nov 2026 20:17:57 +0800
X-QQ-mid: xmsmtpt1795177077t38y1pdw9
Message-ID: <tencent_F83D2E71F8533412D7D7477A7ED9F6459B06@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznHmnIW8AmHMMUTl1dcnq/33/oxmXjr/dj6SajJEFYV2PaN9bftC
	 L969/tGIebhk3akw3EZFbp4AlCrn1JN/S8sSnm4O9UrKnx8jkyRwbWsNFbcOrOJXiZcgexHrTMxk
	 z6wjfOitR4QCkiXB+UNAyeeG5hHi9xUd7ipcAib3eOulEt+TxdYJKEOpnqtw8vvUm57i0jKzL/97
	 V6QmsxSPtq27uWkPtO3FFxe7D4SiyRe8LDaFxpPOHm+1/yPS4YVUbnkubMHXV5a+MxA1NRI4n9HV
	 IK2XQ5DcDhSTp0pEMA66m+M5nJD/nX/2ZQOO9guFXHFAhzc7K9Rb7ZaqLjQz/n+XeDii/JW9z8b3
	 9f2xfiqhywuom6qqTfVUcLNQQ0SN8y9Phf3m8xVbX/3fDKTswj9BjI5DYOoCbWjQOvJl+FPseVHw
	 BJzTwMRdBsaxiHhc/Zgcr9evBetOhr8KPuLDDOz2i4mNIuUinwEpNkRivzk5ozu32msL3Ees4xsY
	 ENWHI8NfBCZzgbZhffNwLOjjDv1bdQ788mnHL1xCrmxOQd1MNkuXLZQ5vd5Wclk/rl2TwPFfDvYu
	 EArgY5Z7tGeisegTLzTBBtr7ghW0dSIiWc4XmYexY39xZldvdCVSvzZJuyQZ90TV7zYNlkSfI6pM
	 SkPHjRqpBwz4RETbsxRHjlU99bXV/rBsjijrwiyy0suTWFwmRKZOPl7feid+npqC0OJSL1C8Dtex
	 CbkMjhWQ6D3BisGc078QqaL1DkQzkeMGsNavpQdTg58XVtMoAbLnKIsqdA/xOA/ft5Pp/GhleMKw
	 3gTRKPSKLMjn71fXpHVH/Z/wLzbQtR4cT0+gsZ9Ba+U2+8tIoRakkVMIgpDCoeq9EsqD3oSG5tc3
	 CO2iAU8reX3pjCEENanUiswSfDrmTAiVJoVlyDwNb36+xG+bxqK2vIqidy+NqclLO/vV7ocupUby
	 VdfAN1vW5yw1da1RyHzQL2I90vCSzNyVc2LRzLXBzD/mkA9JqjPkTv5tpP7Cbc7I37zrNRfiddmQ
	 HbDQxwnalETgj3DxfQDQpIdY34A/Vu6pNbMVYovitRpPXJ3QrAvmNdRinMg4C2mq2qw05Fgg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hang Nan <2122295973@qq.com>
To: matttbe@kernel.org
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 2122295973@qq.com
Subject: Re: [PATCH net v5 0/3] mptcp token hash ordering and token 0 lookups
Date: Fri, 20 Nov 2026 20:17:56 +0800
X-OQ-MSGID: <179517707644.56974.16674613746518125542@qq.com>
In-Reply-To: <20261116145829.96849-1-2122295973@qq.com>
References: <20261116145829.96849-1-2122295973@qq.com>
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

Hi Matt,

thanks, all points taken.  v6 is prepared but not sent: I will wait for
Netdev Sashiko to finish, as you asked.

- Threading: I see the same thing you do on lore.  The patches are sent
  with git send-email, which sets In-Reply-To to the Message-ID it assigned
  to the cover letter, but our relay rewrites Message-ID on the way out
  (the tencent_*... IDs on lore are not the ones the client wrote), so the
  children end up pointing at an ID that never existed publicly.  I have
  not found a way to make that relay preserve the header; if you have a
  suggestion that works with such a relay I would take it, otherwise I will
  send the next version in a way that does not depend on the rewritten ID.

- Prefix: switched to "mptcp: " in v6.

- KUnit test: dropped.  Beyond your point that a !token guard is not worth
  50 lines, it also caused the build failure the test robot reported - the
  case used mptcp_token_exists(), which is not exported, so
  mptcp_token_test.ko failed at modpost when the test is built as a module.
  The pre-existing token tests pass with the series: pass:4 fail:0.

- For backports I kept the code changes as three separate commits (ordering,
  hash-membership check, token 0), so none of them carries test code.

- token 0: v6 says explicitly that no connection gets token 0 from this
  implementation, and that the RFC 8684 token field does allow zero, so the
  rejection is a Linux-side property, not a protocol one.

Two things I folded in from the Sashiko review of the same series, which
you may want to look at when you do the full review:

- [High] The acquire ordering does not cover the passive-open path, where
  sk_clone() publishes the refcount before mptcp_sk_clone_init() sets the
  token.  v6 adds a separate patch that drops a socket which is no longer
  on the chain after the increment, the way __inet_lookup_established()
  does.

- [Low] The stable tag now names the dependency:
  "Cc: stable@vger.kernel.org" plus a sentence pointing at
  7f8ceea0c580 ("refcount: provide ops for cases when object's memory can
  be reused") in the body.

Cheers,
Hang

