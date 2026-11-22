Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795372772;
	b=zl0hxE+dMTdnFVUl5t5XN+5zyZPKqfWDqNPSx3gKBZ67jH1XW9favelzxtNJAT8TcuT5
	 7zGgmeC7JZAcVG/ocst5R3xD+xMj/lHapJ+KBI3k+xkkEb8sfjR2KgZ746L40ZgmaMJEs
	 7ILVO0RfTTbN7unyoErVlrOKAcqO6ihc5Ou54kk7u8H2atXmZGL3ADx8rJ5mk3dNF4V7J
	 R7NO5cUhl2qwKFof1G7yJbooux+DNI68sb52gGElWLLZfOBrsXpSQh5/NubQV78Gfl9H/
	 qAFt2n+1a5/pZSyqeIc0YEbUF9A13uOohiRJLDBJiZyxFEPAzvPIYpTcFLc5h1vqpig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=KF1BQ1zGUNFE9oDyiz0kj0hbMwS6tO2UyjVGPatHnnU=;
	b=rPECoG6o4iqYnN4I/ZJcVKIm0f8hiQGLoXTSgsNYcpS2HTC4XPU5EyS7X1d8P9JlK2yj
	 WepEF3e4IKZqFxYeMjPaS0tg1Kkg2hdo1QiL633BV4Va5q+eqfJpi3Vp7YACsxzY7tIvo
	 C35wpZxTxM6httX2xUVDaqS6oWjJh0r5bveWoNSHXLjwbbxEd/4UjugVGeXTNvys8nR6/
	 T3y3vFdTD8h5e6uKOWqcLOTQsYpPdayzQAzmuDJdUctpXeukhZXIRkH67pkNj1XTjfDby
	 ussteIb/lVcjWvfm8d8DMyfO5OZlHqxPlBwb9bOivlawvaUUABpCGX9a9Oho4+TLnwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKlkiZ9P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F24606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6F24606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKlkiZ9P
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso24746065e9.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:39:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795372770; cv=none;
        d=google.com; s=arc-20260327;
        b=TQjLGUSOkD5rFZlaang3wllqfDLIp7hAgJTDEAPQvpAfWLYVMjOSDzZR73LAf/r2Fa
         RqgnpO6GQnDEspotLnxhRoyKSKrhUNnXns4pf8+FZEro3fzfa5tEPbjDiWmwMPysNUmC
         FxVi4hZDjiNzuQrTRdBv4Z2N132YrLmUOpM/pZFr1D5ch6BZJ1NU32apblfoeNJuis5W
         BMyDdklPbqWWUTI/Y89YJVn1/wOKgK7Aay6RIdLJhHpTAd7XrBuHIcUKXPwqoMuiX+l4
         iem/NN2Z1+NpOxK6iz1D3FAVtOzou6ag+N78L1571MRwLj4PGQWLotZlJ/N/8RpOBoCS
         UyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=KF1BQ1zGUNFE9oDyiz0kj0hbMwS6tO2UyjVGPatHnnU=;
        fh=VMSZDy67JbtICA61VAUG8CamZaF/KLvDFjqY8hSo1lw=;
        b=WYjnxrEy9MWvEY4JtPcvnG/bxqI+z1GcDhqkUf9/v74LlilEbUULpSIgTspWfiRSYe
         FN9/YSiWvHV9ZCMNkv7x0SG9mj05VaYDWTQL3miPZoJU82HN22Ngok3UnWT8JQOtCuub
         XPfH+dICZ9ujych6wcFFO+rRjO3gpqm9Wh0mUBEt59qgR/eOxOi0EekMYtBH3tZibPf3
         Ol5pXSqKlxw3Q4Ia/unsAG4c3df4iFkgxow5bJGLmbV/tmm/bBiJ+37xIrwvToH7Z0ih
         Vz+46XOxX3j98PdTk4FYVfojvmr5S95DjXZC0u9b+LXZcOx1sU2T7Uwqz/0v8MfUXK1j
         cRRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795372770; x=1795977570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF1BQ1zGUNFE9oDyiz0kj0hbMwS6tO2UyjVGPatHnnU=;
        b=wKlkiZ9PAmEfe3rRpGuDQtL28POIqp22tFvP5pT+WmLUuu0r8fNQQ10dL71XnOScTm
         T8uJc47QUn4Zh7KFQQpxEUkwmX519yWAx/+Rz8sccCA2/zlDRN/9FqvPU6y3ramVHPLf
         1AUuVTR5KnER+L/EdtF3brhBWiWj2nDXfN23CpkdiNWhjPp0TQZPYJuerAj6NWtY2imZ
         5SZ99HhyjSjQBA6LHMemxvJMDo0iVvsGy3yWqV96D1CBbXuH4IJi7t/+IZ5TRfeHlRp5
         boteLj9xN8x758GOShXsD4Wfro+U1HMFJzhVuACtGs1gwkOrjfKRgpliARVLtDSdo8EG
         5Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372770; x=1795977570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KF1BQ1zGUNFE9oDyiz0kj0hbMwS6tO2UyjVGPatHnnU=;
        b=f6YizSigd/AVq+SPphAO1XBTpmjZiDcOP8wa+SRN3rZQCbSTZNjKiYEyyU1RT+qXaH
         ec6pkHIdg735KHw5VW9BAuVFQdEOMfJgb6RcBjjCIV8OVCp7O+VXmddPi1Qn2CB7lII0
         FheEMGyURTn66Eg2xbH2trKfaoJqjBYlGlKDcUUn/h1nRtygNGQqyXyEYMfUEDqpLiAj
         RJvYHEURRCio/NalmMpBW8HJVgvo8e4m9JZSS2dQ0z8Q4FohAIGgLX1C4T53NR3JjSvY
         F1C85Jah1Iz+GEw/yz/+ViiqYHGzewgMtLd3915yNojl1LxZpEoUBZgAwB50Ny4f0vJB
         SlXg==
X-Gm-Message-State: APuU4Z8j1zrUv6Hlp83fWna5kSsgCtYBr63RPTtGt6QznDdpNP61VvQa
	HnqdtSfK1Wymq7E5DIIbACkfE6ztjrZYLEzlt8e7G9xOmq96jRzzH+F9K7GcoxOoo7lF/9c2Ee1
	NqlnVwLEBbHDUOp9BeGLmh0x7IcjFyJ1BN7NC
X-Gm-Gg: AZFdTZdLfmZmvZi+q1BFNg01KcPbVnFWNfT5VG7pymmADBdh0Nt/IzmhRL83kTKYg+X
	ZFhYHBII9HF18ZujjtjTSinhJAnu6FoN2WivanwaiEa4filPTmRcta54R1SlyKTq4RcBAH36mQJ
	glqiJlRYUmYEPkZr64SyY7d4j7Y0KmVHutPgy95ZVflr6CDB74CKeCYO6c3IjsDnbhwyWlWONab
	WzYz+YnVL7cFtoflsryRfQlJz9saQqJFty7J6wfOwXiyZ2VRbkT1J42LwOn2HIGWhR4vyenEUT8
	OXG+X2+fOOTVB2KlHWXTv28Qdbg8G7TWgcTO3Ci+poH4VgM+Cm8IPQqQNt5QKGoB6QqZYJZH5AJ
	NflzClIWCjXzBIEpWhtmk8UtI1oIkzZ3CEIU=
X-Received: by 2002:a05:600c:674d:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4bb88808263mr213347845e9.14.1795372770161; Sun, 22 Nov 2026
 10:39:30 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Iulian Vaideanu <iulian.vaideanu@gmail.com>
Date: Sun, 22 Nov 2026 20:39:18 +0200
X-Gm-Features: Aa3M54p1PncJVptZSDa2qFfk8dNzLdzgxMitxRzaH6ZahobGYitQ66D5KOPv4nI
Message-ID: <CAPK=yVMe1Ro=aw_daLCOM9cBATsp6crdgB4wd0ty4vrnxtVKkQ@mail.gmail.com>
Subject: Unable to compile 6.12 kernels on SPARC64 since 6.12.105
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Ever since 6.12.105 I cannot "make bindeb-pkg" vanilla kernels
(platform is Debian unstable on bare-metal Netra SPARC T4-1, GCC 16.1
or 16.2 from Debian ports) - it always ends in the error below in
fcntl.c, probably brought up by one of the fsnotify-related commits in
105.

Is there anything I can do to work around this?

Thank you.

Iulian

  CC      fs/fcntl.o
In file included from <command-line>:
fs/fcntl.c: In function =E2=80=98fcntl_init=E2=80=99:
././include/linux/compiler_types.h:543:45: error: call to
=E2=80=98__compiletime_assert_443=E2=80=99 declared with attribute error: B=
UILD_BUG_ON
failed: 21 - 1 !=3D HWEIGHT32( (VALID_OPEN_FLAGS & ~(O_NONBLOCK |
O_NDELAY)) | __FMODE_EXEC | __FMODE_NONOTIFY)
  543 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:524:25: note: in definition of
macro =E2=80=98__compiletime_assert=E2=80=99
  524 |                         prefix ## suffix();
         \
      |                         ^~~~~~
././include/linux/compiler_types.h:543:9: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  543 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:9: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
fs/fcntl.c:1169:9: note: in expansion of macro =E2=80=98BUILD_BUG_ON=E2=80=
=99
 1169 |         BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
      |         ^~~~~~~~~~~~
make[6]: *** [scripts/Makefile.build:229: fs/fcntl.o] Error 1
make[5]: *** [scripts/Makefile.build:466: fs] Error 2
make[4]: *** [Makefile:1983: .] Error 2
make[3]: *** [debian/rules:76: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess
failed with exit status 2
make[2]: *** [scripts/Makefile.package:126: bindeb-pkg] Error 2
make[1]: *** [/home/linux-kernel/linux-6.12.118/Makefile:1604:
bindeb-pkg] Error 2
make: *** [Makefile:224: __sub-make] Error 2
