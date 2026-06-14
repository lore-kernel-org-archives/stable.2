Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AA286D4D
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781474765; cv=none; b=b0lK/DDQT0uoj8u4nNvPfgz7pIMzU5OmIKlCgXO8Pnv+BVZz0+50uHbWi5S2jGWYvLXkXcsncly6YZUvQmVKloQO0MEYI8aIPO/3Zcc0tvIHY4zCS42dO88fHzfi3HewcsjgJqq5HERUpY/h8l2AfqncLdxb4qH3Dkbb2ov8BEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781474765; c=relaxed/simple;
	bh=VOGjGxYzqa8UO0a2TvxCyI4oO8Y3YUS//HdkrU1sDK4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OS/xhGSjk637WS1SV+6DqAQmb+wgb+w5t+M5aeMugPkuNTNtY0WfFTOLV0g4XnKHcC8B3fkeupu/9Mhr6Ms/OclrNOEvkkdf4xRwPHJuBC9/faPgmTMSLNgiInoNXrxgUkCr8bCaXqyBQvr+B5jjorvIqu1Q+mP03MVm+HVmbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-69d9f54ab77so2336809eaf.0
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 15:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781474763; x=1782079563;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvJhKDchvA8MuraLz/XfqkV+65Vr39S/XOxyKvZf2D4=;
        b=GoQUBD0JGva8tkGZvRWos2J7r/WXCv4hsas3rGwrDZe+nMftklk2Qk3grj13zqNjlb
         x/4qQ58FokMDr/QNxvI7JAE8xJGiH/YIW2CnrKPc93jDzfI9fautxH5zU4V+k4Z1Ddvo
         fG7buIdfNp8XWK7DJa715HriYzElRiibhWM6QsePSJuyQX5Aj3Z4GBx1Q94nT4YogRtw
         za3awBpnErjnyAC4Sj9IAbIT4xqKThw1cAth6rHMdw8WS8XnyFrzu5LtEjN/xRyZKmKb
         9QbfeV6Oz9h4TGVpBbrH0sKzdyzDb/LLTMc5QBl5otjWTa+co7fgKY7lxVtwVZFUD8Hf
         /+3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+gTmxhGib0BF//AK+jFjazCULlRH07zh6nMYsHeFcDg6QK43/t/MXVnobmxmJ7u9CDQ8BQx8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlD5QwyYpdRFhSew/n3rLfivVWFfGxMRX15LofLTbCuAxW+YvC
	1tGq+XZzLBurRgHvmRa+3ZZ1s6VrFV3Vjb4Vc/3IX+u9FrodK0SOHzY6IxK4/szzf9+N5GDZGoB
	isTS6pVnfpuS4K6LJ0mzq5kdyBT8fCd571AcxBhOo11/5TCCUuSRJbpWwcR4=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:11ca:b0:467:1941:1f0d with SMTP id
 5614622812f47-487419a2c14mr5589691b6e.11.1781474763605; Sun, 14 Jun 2026
 15:06:03 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:03 -0700
In-Reply-To: <20260614214150.1791-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2f25cb.be3f099c.2836ae.0011.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] possible deadlock in keyring_clear (3)
From: syzbot <syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, hdanton@sina.com, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, med08elkadiri@gmail.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-execprog to VM: scp failed: failed to run ["scp" "-P" "3=
8817" "-F" "/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "Identiti=
esOnly=3Dyes" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o"=
 "ConnectTimeout=3D10" "-v" "-O" "/syzkaller/jobs/linux/gopath/src/github.c=
om/google/syzkaller/bin/linux_amd64/syz-execprog" "root@localhost:/syz-exec=
prog"]: exit status 1



syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2355215050=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.26.0'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at d1b870e1003b
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251128-125159"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251128-125159"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd1b870e1003b52891d2196c1e2ee42fe905010ba -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251128-125159"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d1b870e1003b52891d2196c1e2ee42fe90=
5010ba\"
/usr/bin/ld: /tmp/ccw08xaS.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x386): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         8cd9520d Linux 7.1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcfff134d62ee3b9=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3Df55b043dacf43776b=
50c
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-=
1~exp1~20260514074407.73), Debian LLD 22.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1400e8ae5800=
00

