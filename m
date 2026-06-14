Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B427603F;
	Sun, 14 Jun 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781423390; cv=none; b=uabrK8HfleU7fpJQWfjBswNi5IpBoEDea6Xf0AV91dOSJBC5+pNiS5ATV8unn1S9/cjZT2UYZMxKe6NmnEt59N/V7D/H9vtGA7bhrMmnQCePnTUHI+orNi3TWENU4lBlP3oPCNW/E74tngFHUYurdz26vWIA3t3guJpylJvKaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781423390; c=relaxed/simple;
	bh=rLneSnfI+cOEZE1DXR5m4pXRZinG3H0vkJIHnFF6Y64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OycjO3r6VB5aG8MFWFrho85CTbAv+MSHHVMVdH073Jj+JMSxy6vPbEJ1YaqUfF7/jWneFy99PLz4GbkEQIKmb55OYb0VYPTUIoCJ3/iHG89kziPiaHuPIrmtQLWUn3QjuYfj25RL4Zv+Ekzoe4DJZQEtSpn4tiSkP04RtnQRkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=ek+6nwUJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="ek+6nwUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1781423386; x=1782028186; i=aros@gmx.com;
	bh=kr4+MYzhOgQWjZPUEO/g/d5b7EB7U8bI8dOrhPm1Cr8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ek+6nwUJIzZOLLd38IiYitX0d3fuQQV9zWpM+IDPhLtLVWtxFbM2TebgBNBdETmy
	 tnOVW+KT/L4+vokqEc8W0pgXiDgw/9ZGv2nx7lJMYCJCPrT4G9YxImG8lY1htoB8T
	 U0PvfS3fJRvSzVTcVkK20IC4fYeq4qtIPaH2nKTFnxL1FhOYHLM3kA1qix6D2HGPr
	 VcnSwibuoChN40YweD4YnD4fGbTLdc9uFnoQS3jtCBWuca4kY0idDPmSlfhb+9f0I
	 bNmQH2vz7YaxsQDgq+zWgp3sEeHWnPEcTjMVioTmhC4vsSbDh9Q87yW73l2oXi6LN
	 QYhqVg2GthmkGfYr3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2E1G-1xCuWd49ao-00ru8U; Sun, 14
 Jun 2026 09:49:46 +0200
Message-ID: <c526fab7-c323-4712-989b-88c4da82a289@gmx.com>
Date: Sun, 14 Jun 2026 07:49:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC/PROPOSAL] Shifting the x.y.z Stable Tree to a Continuous,
 Signed Patch-Stream Model
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <cdb0dd2f-f331-46ed-8439-1609173f083a@gmx.com>
 <2026052444-unlawful-eskimo-9c41@gregkh>
From: "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <2026052444-unlawful-eskimo-9c41@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:soW/S79zUlA2yNiHUgMPm+KVVj56fRVDN91p5PZd705OD7FGFqK
 TgB+NNpc5RSMb2qxyqHY8+usmRc5qJxxJOZNmYRTL1o2oaaJG/wPrS9EFp+CmGUakn24KKn
 Ndr4byaiWo55uTKTC1QY99LwqN3V0r2K8WJLAN5ReCpiXAxw7zy9NmAzMrWF0CwNWxr4fbR
 ixFTE5mLwxLOOQ03gN02g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J9189sXbKb8=;18U0i8hIhMXlLsCDU1EXdSaIGHk
 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
 DLjSPKnKvHaVviiMRytzIokcLpg=



On 5/24/26 10:56 AM, Greg Kroah-Hartman wrote:
> On Sun, May 24, 2026 at 01:38:55PM +0400, Artem S. Tashkinov wrote:
>> Hi all,
>>
>> The relentless cadence of critical vulnerability disclosures and public
>> exploits over the past month=E2=80=94including Copy Fail (CVE-2026-3143=
1), Dirty
>> Frag (CVE-2026-43284/500), Fragnesia (CVE-2026-46300), and the ptrace e=
xit
>> race (CVE-2026-46333)=E2=80=94has highlighted a severe structural bottl=
eneck in how
>> we package and distribute stable backports.
>=20
> Who is "we"?
>=20
> And there's nothing really "new" here, these issues are all normal,
> remember, we resolve, on average, 13 CVEs a day, most much more severe
> than the ones that happened to get marketing names that you list here
> (and how many systems have untrusted users?)
>=20
>> When fatal logic flaws or memory corruptions strike core subsystems, ou=
r
>> current point-release model fractures. Spinning up whole new point rele=
ases
>> (7.0.4, 7.0.5, 7.0.7) in a matter of days just to address incomplete fi=
xes,
>> subsystem regressions, or independent public disclosures (such as the r=
ecent
>> GRO managed-frag UAF exploit dropped directly to GitHub gists by
>> researchers) creates massive administrative fatigue for maintainers and
>> downstream teams alike.
>=20
> it takes just a minute to "spin up" a point release, what is difficult
> about that?  If needed, just let us know and we can easily do so.
>=20
>> Upstream has long maintained that the stable tree is effectively a
>> continuous stream of fixes, and that users should track the tip of the
>> stable branch rather than cherry-picking. It is time our release
>> infrastructure matches this reality.
>>
>> ### The Proposal
>>
>> I propose transitioning the stable tree (`linux-x.y.y`) away from
>> manual,discrete point-release tarballs (`x.y.z`). Instead, we should tr=
eat
>> the stable sub-version purely as an append-only, continuous, git-native
>> patch stream.
>=20
> That's what we do today, we just happen go "jump" on a weekly basis.
>=20
>> Major releases (e.g., 7.0, 7.1) remain the foundational code boundaries=
, but
>> sub-versions are eliminated as monolithic manual artifacts.
>>
>> ### The Implementation: How It Works
>>
>> To ensure downstream distributions, enterprise compliance engines, and
>> automated testing rings can still securely ingest code, we can replace =
the
>> manual tarball with a decoupled, automated asset pipeline:
>>
>> 1. **The Git-First Stream:** The stable branch (`linux-7.0.y`) remains =
the
>> single source of truth. Commits are pushed as soon as they pass stable
>> criteria and automated sanity testing.
>=20
> Again, that's what we do today.
>=20
>> 2. **The Signed Patch-Stream Archive:** Instead of packaging the entire=
 30M+
>> line source code tree into a new tarball for every quick fix, upstream
>> infrastructure maintains a rolling, cumulative patch sequence for the m=
ajor
>> cycle:
>>
>> linux-7.0-stable.series =3D \sum (patch_1 + patch_2 + ... + patch_n)
>>
>> Every time a fix is merged to the stable branch, the patch is appended =
to a
>> publicly accessible, cryptographically signed manifest file
>> (`linux-7.0-stable-patches.tar.bz2` or a standard `series` file) alongs=
ide a
>> detached signature.
>=20
> Who would use/need such a thing?  What's wrong with the 2 systems we
> have today that this would somehow help out with?
>=20
>> 3. **Automated Snapshot Tags:** If the industry strictly requires an
>> immutable archive for compliance,
>=20
> What "compliance"?
>=20
>> point-release numbers can be replaced by
>> automated, time-stamped git tags and machine-generated source snapshots=
 cut
>> on a strict, automated interval (e.g., every 48 hours), removing human
>> maintainers entirely from the release timing.
>=20
> That's probably not a good idea anyway.  Are you doing continous testing
> of the stable queue?  If so, great, just take from there today.
> Everyone adds patches on top of releases anyway, what's a few more if it
> happens to resolve specific issues for a day or so before a .y release
> can be cut?
>=20
>> ### Why This Benefits the Ecosystem
>>
>> * **Eliminates Churn and Latency:**
>>
>> When a patch introduces an edge-case regression or requires an immediat=
e
>> follow-up (a common reason for rapid point-release sequences), maintain=
ers
>> do not need to coordinate a whole new release event.
>=20
> No real "coordination" happens here.
>=20
>> The follow-up fix is simply patch $n+1$. Downstream CI pipelines
>> ingest it natively via standard git fetches.
>=20
> Again, we do that today.
>=20
>> * **Maintains Git-Native Debugging:**
>>
>> Debugging stable regressions via `git bisect` has always been patch-bas=
ed,
>> not release-based. Since point releases are meant strictly for backport=
ed
>> bug fixes, removing the arbitrary `x.y.z` release tags changes nothing =
about
>> a developer's ability to isolate a regression. If anything, it prevents
>> downstream vendors from pulling out-of-order patches that complicate
>> bisection across distros.
>=20
> Who bisects across distros?
>=20
>> * **Eases Downstream Automation:**
>>
>> Modern tracking distributions (Arch, Fedora snapshotting, etc.) can swi=
tch
>> to trunk-based intake, automatically building from the signed tip.
>=20
> Have you asked them if they need/want this?
>=20
>> For enterprise distributions (RHEL, Ubuntu LTS) where constant kernel
>> packaging and reboots are untenable,
>=20
> Why are reboots for these systems untenable?  Why not fix that root
> problem instead?
>=20
>> a fluid patch stream allows vendor
>> security teams to more rapidly feed live-patching infrastructure (`kpat=
ch`,
>> `kgraft`), applying critical CVE fixes directly to runtime memory witho=
ut
>> changing the base package version.
>=20
> They can do that today, and do do that today.  So again, what distro
> needs this?
>=20
>> * **Bridges the Compliance Gap:**
>>
>> Embedded, automotive, or medical compliance pipelines
>> that legally require a static, verifiable code artifact can validate th=
eir
>> software against the base major release tarball ($7.0.0$) plus the
>> cryptographically signed, append-only stable patch series manifest.
>=20
> Do they really need that?  Again, they can have that today, nothing new
> here.
>=20
>> The manual compilation, testing, and cutting of sub-version tarballs is=
 an
>> administrative artifact of the late 1990s.
>=20
> Weekly releases is not an artivact of the 1990s :)
>=20
>> Shifting to an explicit, signed
>> patch-stream architecture acknowledges the velocity of modern vulnerabi=
lity
>> research, strips away artificial latency, and frees our stable maintain=
ers
>> to focus on code quality rather than release management overhead.
>=20
> Again, we have that today, on a weekly basis.
>=20
> greg k-h

Hi Greg,

I understand completely that from an upstream maintainer perspective,=20
the current pipeline feels seamless. Running a script to cut a tag takes=
=20
a minute, and git-stable is inherently fluid. But looking at the=20
ecosystem from the downstream and infrastructure side, the view is a bit=
=20
different.

Here is where the current model introduces friction that a patch-stream=20
or automated snapshot approach could solve:

### 1. The Compounding Downstream Tax

When you spin up a rapid sequence like 7.0.4, 7.0.5, and 7.0.7 to=20
address the immediate fallout of complex CVEs, it takes a minute for=20
upstream, but it triggers a massive domino effect downstream. Hundreds=20
of distribution mirrors sync gigabytes of redundant source data, package=
=20
maintainers rewrite specs, and automated build farms recreate full=20
packages. When a fix is incomplete or causes an immediate regression=20
requiring a follow-up version 48 hours later, that entire global compute=
=20
and human cycle repeats for what amounts to a few lines of diff.

### 2. The Infrastructure Reality of Reboots

You mentioned that systems should just be fixed so reboots aren't=20
untenable. In an ideal architectural world, yes. But in production=20
reality, orchestrating reboots across thousands of live cloud nodes=20
running high-availability workloads carries immense risk and scheduling=20
overhead.

Enterprise distros absolutely do use live-patching (`kpatch`/`kgraft`)=20
to mitigate this, but tracking a shifting landscape of discrete=20
point-release tarballs complicates their internal backport verification.=
=20
A continuous, signed patch-stream would give vendor security teams a=20
clean, linear ledger of upstream-approved deltas to feed directly into=20
live-patch compilation engines without the noise of full tree packaging.

### 3. Archive Bloat on the Mirror Network

Every stable point release requires a new ~130MB `.tar.xz` full source=20
archive. Multiplying that across multiple active LTS branches, dozens of=
=20
point releases, and hundreds of worldwide mirrors results in massive=20
data duplication just to distribute a cumulative handful of text diffs.=20
The ecosystem is essentially re-shipping the entire ocean every time we=20
need to add a cup of water.

### Why the Proposal Matters

When independent researchers drop working exploit primitives directly to=
=20
public gists (like the recent GRO managed-frag UAF), the turnaround time=
=20
to protected production systems needs to be near-zero.

The proposal wasn't meant to imply that the stable team isn't working=20
fast enough=E2=80=94you guys are incredibly fast. It was an observation th=
at the=20
*delivery mechanism* (the discrete, human-timed tarball) forces=20
downstream consumers to choose between packaging fatigue or artificial=20
patch latency. Shifting the sub-version boundary to a machine-managed,=20
append-only signed patch stream bridges that gap.

I know you have a workflow that works for **you**, and I respect the=20
hell out of the massive volume of fixes you ship daily. I just wanted to=
=20
share the perspective of how that weekly "jump" ripples out to the=20
people who have to deploy it.

### Truly Massive Distro Churn Issue

There's also a very important downstream packaging issue that I think=20
the current stable-kernel release model underestimates.

Debian and Ubuntu already diverge from the upstream stable versioning=20
model in a useful way: they package kernels around their own ABI=20
versioning. In practice, this means they can often ship fixes without=20
forcing users to install an entirely new `/lib/modules/<kernel-version>`=
=20
tree every time an upstream stable micro-release appears. A new=20
ABI/package line is only needed when the kernel ABI they expose to=20
packaged or out-of-tree modules changes.

That model is a major downstream advantage. It avoids needless module=20
churn, avoids retaining multiple near-identical kernel trees, and makes=20
security/regression updates cheaper to ship. ABI-breaking changes do=20
happen, but in stable kernels they are rare enough that treating them as=
=20
exceptional events is perfectly reasonable.

My proposal takes this idea further.

Stable kernel releases frequently contain important fixes for=20
regressions introduced either in `.0` releases or in earlier stable=20
updates. But the current release cadence means that downstream=20
distributions often have to react before the next stable point release=20
exists. They either wait, leaving users exposed to known regressions, or=
=20
they cherry-pick individual commits from the stable queue. That creates=20
avoidable work: maintainers have to select fixes, update packaging=20
metadata, rebuild, test, and publish a distro-specific kernel update=20
that is supposed to correspond to a =E2=80=9Cstable=E2=80=9D upstream seri=
es.

Fedora=E2=80=99s 7.0 cycle is a good example of the downstream churn this=
=20
creates: multiple downstream updates may be needed for what is logically=
=20
the same upstream stable series, simply because important fixes land=20
between formal stable releases.

Under the model I am proposing, stable would be treated less like a=20
sequence of isolated point releases and more like a continuously=20
updated, signed stable branch. Distributions could pin a specific signed=
=20
stable commit and trigger a rebuild from that point, instead of=20
maintaining their own ad hoc selection of fixes while waiting for the=20
next point release.

This would not remove the need for distro testing or for avoiding=20
known-bad commits. But in the common case it would simplify the workflow=
=20
enormously: downstreams would consume the stable branch directly,=20
rebuild from a known commit, and get all accepted stable fixes together.=
=20
Only in rare cases would they need to temporarily blacklist or revert a=20
problematic stable commit.

That is still much easier than every distribution independently deciding=
=20
which urgent fixes to cherry-pick from the stable queue.

The end result would be less downstream packaging churn, faster delivery=
=20
of regression fixes, fewer distro-specific stable-kernel deltas, and a=20
model that better reflects how many downstreams already consume stable=20
kernels in practice.

Best regards,
Artem

