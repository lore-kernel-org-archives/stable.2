Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589009;
	b=zBXRfH6Gs+IqjlTuQAN5I69y1x1i6OPST834FAbU1sRr+O/oMPvcmd9rfkWBWqVzCwo2
	 xR8P9qCLfL/aFA0IpB6KlQC2f06/u81oHMn0EUMhUDyy+SM7LxftEzeMtmLV7HxjkQkgj
	 oOSfTivTzcHjBgfVDGh2Rg6oSgsMowTgi4l8dkVYFux7zh6JnukuX0yFgbrHNivNFCYM3
	 UngwcSw7O0Ex4IR5efrmFNgwWq8V3c/4sxtTWTwki4ERryE5pYx3X36jM62JS1LVxdl05
	 oK7/kNHdbiL75ACN54v4Aya27gyB2xjIDKYtMJ66MlJmaAc0CHP0FIAFAMnDNcz5YLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589009;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5hzEwCw8ytaH6XOSTbdNB/Jv8UgZrq9U0lXcnqhzXsE=;
	b=yUEdBdbbF9ht1tJAQOu4mLB8y9Ntolz7tKOFXf2kVzn1dQlxNQpy0Ttk98IPOufduIsm
	 R/QK7dRzrSvniHYUmQpXr2yznlIMILyIOhAqz3GX8mQjO71hXbSXgp5u2aMISQ4qfByYk
	 O7YBjdQ1+OIB47ZwvsIO364ygaG4kCh1+faqgLtHQls1ZhqpAXexQf+6ugNwoAJbTEUxg
	 AKT321bbUt7Ebqev72a9r+93FLxYbqIa8LzbMDVMANC0PBAHROPFZEgRn0ELhaLHjJ4qj
	 XYuHM15cZDZKjPfWdnhQPnMt7gngkTwEX8tDWQXNo3Xe0CdLItoEOoUTLpRWVKJR7vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyYEY3mu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F124606A31E;
	Wed, 25 Nov 2026 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyYEY3mu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764771F000C0;
	Wed, 25 Nov 2026 06:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795589008;
	bh=5hzEwCw8ytaH6XOSTbdNB/Jv8UgZrq9U0lXcnqhzXsE=;
	h=From:Subject:Date:To:Cc;
	b=TyYEY3mu2ZyZgg5PExsQAI1/wtCwpgu70CXdVO/6zS0lumwVh0VWwu//D8ExLp7zy
	 /eB1Dd+4OgYCvcCbhkBLrPS0VSa9FS2T4jB+jNNBiq9z0hAYkmWLlpxzEIxMpbNn0S
	 HfDKA/z915TVTracHPV8F16m5VM1h4yYrWGrSAx0nec3+4Ss5TAdOBMaemEBZNvwhF
	 oGmnDAwZm6iU6Tgb/GvZ4eYX+Avg+RbdA0nsv7b0DIs/ggJFLzOhYGi26uP/UzvFkz
	 XNp51jRjzyWNLvYewpx3HSK8m63RgsfJKCCHrEfL3y3BIRr+BBjL81jynD2dyPDzgi
	 y65HKxcYN8N6g==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 0/2] x86: Avoid CONFIG_X86_NATIVE_CPU=y when cross
 compiling
Date: Tue, 24 Nov 2026 23:43:11 -0700
Message-Id: <20261124-x86-no-march-native-on-non-x86_64-v3-0-268354149c5f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/5WOyw7CIBBFf6Vh7RiBitSV/2GMATq1+AADldSY/
 rugG93p8t65OWceJGKwGMm6epCAyUbrXQ58VhHTK3dAsG3OhC2YoJRyGKUA5+GigunBqcEmBO9
 y5cppL2qQknGua6lW7YpkzjVgZ8eXY7t753jTRzRDAZdFb+Pgw/31RKJl948vUaBgtJF60YiWm
 npzwuDwPPfhQIowsU/k8hcky8hO864RvNZUmy/kNE1PP1xBJjgBAAA=
X-Change-ID: 20261113-x86-no-march-native-on-non-x86_64-88233b48a7d7
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Julian Braha <julianbraha@gmail.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, stable@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Evbp4fCKJyX4p3JTCj/jaQPeXVTACj3MLjZz/W4+f4c=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDNlszZ0pZ1N3rdx69Il+TojEuisfrufVi/X2ajwTzvn6q
 HPe+TVSHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAi7OsZ/gfmJXMvuJtwuyEw
 vaNMwvv8r+VJZQqZ8+W51m6IUXWpsWZkWL9sHru/6R7deddFD2zc8+WT6E2DaTK7XK+K7Yj8l7l
 lOwcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

This series addresses an massive spew of warnings that I see when cross
compiling x86 allmodconfig on certain ARM machines. To resolve these
warnings, introduce a Kconfig symbol for when cross compiling and avoid
allowing CONFIG_X86_NATIVE_CPU to be enabled when it is set.

This could go through either the kbuild or -tip tree, I don't have a
strong preference.

---
Changes in v3:
- Introduce CONFIG_CROSS_COMPILING to perform the host == target check
  from v1 in a generic way and make CONFIG_X86_NATIVE_CPU depend on it
  not being set (Linus)
- Add bug link to second patch (Nick)
- Link to v2: https://patch.msgid.link/20261115-x86-no-march-native-on-non-x86_64-v2-1-fb3f9634b1bc@kernel.org

Changes in v2:
- Rather than checking if host == target, just make X86_NATIVE_CPU
  depend on !COMPILE_TEST, which makes sense anyways (Borislav)
- Link to v1: https://patch.msgid.link/20261113-x86-no-march-native-on-non-x86_64-v1-1-cbc8b096d1c4@kernel.org

---
Nathan Chancellor (2):
      kbuild: Introduce CONFIG_CROSS_COMPILING
      x86/build: Do not allow X86_NATIVE_CPU to be enabled when cross compiling

 MAINTAINERS                      |  1 +
 arch/x86/Kconfig.cpu             |  1 +
 scripts/Kconfig.toolchain        |  3 +++
 scripts/check-cross-compiling.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 31 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261113-x86-no-march-native-on-non-x86_64-88233b48a7d7

Best regards,
--  
Cheers,
Nathan

