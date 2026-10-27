Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793076672;
	b=YBk/05BE/lWsP/E73kM4LdIDSd/MlSy+w37+LgymueSoF77Fty4uf2iHSu9TWNIZi1hL
	 iae3G+Q0J9JNIT9YCkv55CjRgT4/vXQt4JHp5ARHDyNlhiS4qZT9NeEte8Lspn1JGcMLB
	 9ZGbJpIapMb4fcb9U7DGzmX6j+hubYifHjOav1HXyFzrl8yfOIRjGNoRfJYLx9v1yg5tZ
	 tzC+mg65whfjYGJ1lDOJippPI87aKthCf/pwRpCkGUWLlsOA2ODFlnZdHxgZJhqsKGotE
	 w9ihmHu0GbZ9eLOfvda0xLdxY3++zpt8SLFsKP1QSVsQW+hueiRNNxSwAUA5Rxt4qPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076672;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UorkZN7XGO6iTpvoLvTmemMJ2RzNdn72w5oN6AlbaTc=;
	b=tJAkVEUCGa/bXCsGxdVBIUPCbXBGyp1uZmfcIR482NS0Iy4wZH5TFVljsg1ZsrKVvwig
	 giDtCAorBGhW9syA+1OLMByJyJY/Jvzx8q6UNu+poJZVAUTYR9tgVsN7pzQcmA4TSv8mW
	 Sky7RqkbPdDDdnjTSAPPn3SWhlXtOhLUkdOSqnXcWndUhMqi0x9tuSVegrV4uFmcK3oCT
	 DbEpukiQVg6eAGn1regC6JoIfPGy2RlscBhCHb6ak6okntcbp2lAEQRFlPkouC+r8tw+n
	 aj0YuJIERhUZx+53JvkRv2ATuiqZeey/KGEL4Hcjy4NEWLzkolK/z2ODwt4ruaVWpBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LYM5HoMj;
	arc=none smtp.remote-ip=203.205.221.236
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382F606A31A;
	Tue, 27 Oct 2026 04:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5382F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LYM5HoMj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793076666; bh=UorkZN7XGO6iTpvoLvTmemMJ2RzNdn72w5oN6AlbaTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LYM5HoMjLp2fnyYyMLHmEEsZ6Pc6H4J80F/wJZ+8Zfsct8nxjkVpubi7Z2pJPm6zq
	 2MK5IpQaYAZIZNm1/5xq/w/X/HEwxG2tEn7y8/r6Gva+t84Pnb2tY6NI0f4XdrNxL6
	 +C5cHLn4VFjiBtEiRhvJFOSBlQ6CcAZtKu56nxcs=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:ad3c:addd:6586:2a94])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id CC41E4C1; Tue, 27 Oct 2026 12:51:04 +0800
X-QQ-mid: xmsmtpt1793076664t4f3k1b4q
Message-ID: <tencent_604E28FF9F3ED582CCAC563D0788102E8109@qq.com>
X-QQ-XMAILINFO: OEUhVsHQax4MacOqvanj1DwW9XK6UfrtiZ7MhPCNLdhXV5VcJwJw/9pM8kYm8X
	 Y4Bt8XvuziYr3chxXzmw/aznxt6hWwlICeMR7O74mgCgeCxqCfniujwxPAe4yq/E160FqjWQvVUX
	 ZP7Fwq0WxPwMl9VZWhB+GzdsEN5rboOSH/i+ob8A/SXrNog52jtHq/JoZsULLsJfmtr4W+9cTHph
	 XPfOXiZ2KZ+JoI2alMIRq76G3CzAbxcpHtGX+L7wegJocSBbNWe0thzhjS1eldqvWjNSiGI1B6zk
	 UtwlLdzeC8s6FdpKf+ooHgdGcq92So11e1zq/vPbQS8JbbicUtSlT/FZ5Sb7ByWW17V2KOFciSEi
	 Rc8CcWIo6/yz5XfNnqmRhqKe0qD/dEr10RlV3UyKtHD5rrnc28sBwnBDKVTRGAOnmqrUQ6lvOjsz
	 TkkKMhgIbn55P2Ah2/FeHl7qem/0Dz+LiKGgC2rXT7GRIHxS7AOHsk3PWfHNgxy3bNr7g+M+hKRM
	 tcxQKyqz3LFF77FRMWTtQSbKZoA3haJuOfaYFm3Tpk0DyFf7mwLlVQWzBemnTRkTn//z6IuATbKS
	 PcbHAJh2ICsAQ7koErnN1MJiZBrwmS1Wy7RLqH/yFewM5nue2kKoRBiFqr8gx2XRJFkR7zQfv5i9
	 bIfzBCoYuwTnVlE34jAuMCLkDP4sfHhx1cQsNIHKxsna0P0qBFIGW2/PSaWL2OuMTUpSu/8OTNTI
	 37chlhLiKnSAKhBYx8JFQc+XQCbm6ijM+YCdrTl1WJOy+j5d1QiKrlSeFQ2LiCydlKDlcuDkeD4k
	 /uk//zEWeF+UUBHmM+szYPlaMsmJJLMzWsovhp4gYb74Wm4TIvSQc+BQMOUzIa+FHsCroLxhBE7m
	 Frg0mDXRT4k08GuXKb9VpQM5gBrokGyMmpPU7fch2J0QI1Ig4qmCqMx6VvbHVFkV0uNP6UpuuEoK
	 MOOP/VudDiJX56mBQ4qle/hId1jD7wmN0e1OYQN236WFs1dFKT186Bx1/O9jgoVXhvBgaV23dX0M
	 Q1go2u3CL2+vv+MI2U9376EusoAXya5OLN4/j8yri8EcsuYOEsRI/7BfZrw9Y=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Yingjie Wang <1075151112@qq.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] af_unix: order MSG_PEEK references against garbage collection
Date: Tue, 27 Oct 2026 12:51:03 +0800
X-OQ-MSGID: <20261027123817.af-unix-thread-pointer.0d699734-c1fe-4ef3-ae49-db494da51216@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auABC6uMYxXmPqtb@google.com>
References: <tencent_287A56749EA8448A970F2715FFF29F334108@qq.com> <auABC6uMYxXmPqtb@google.com>
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
Content-Transfer-Encoding: 7bit

On Tue, Oct 27, 2026 at 01:42:05AM +0000, Kuniyuki Iwashima wrote:
> Actually there is another thread going on for this issue and
> I suggested another aproach, so ...

Could you please point me to that thread?  I could not find it in the
recent netdev or Patchwork archives.  If it is not public, should I wait
for that approach before revising this patch?

