Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EC2D1F7B
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792276509; cv=none; b=led9Q6uLg8/uIAmZg1gifWEvrQdbohFPRYoFBOhF3vsg0wSwUdHoGdc6OmLLXEIwy1lfhoh5HHnQCV9esrMwkd7Fk9EfCdKIK0pFaqhOoefrFt+3AcJcQvc2oR7jTSltRDCD13115bqBzzKylJ8M0B+FM/yVGPXckns50/ZgJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792276509; c=relaxed/simple;
	bh=eMD/z5ouOPSSIXAXetxHaLog9Ak4StbU4LvjbPEuOsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GyabxlVGe5N98J1Rhdsb8TfhuH61BxLtxjJrA84933yBMW7IkRPtxLvD3dhfonwqx0ApLEchWjT30bp3FQumfvnV3aDkzuzjkYew2HWWLCDsO4t2sTX8+xQdRwjw9RvedGeQcNwONfy323q1+h7AJzPe5a3J/RvSkR54eBsS7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=BhMBI12v; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="BhMBI12v"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67989a2f9bfso533555d50.3
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792276506; x=1792881306; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMD/z5ouOPSSIXAXetxHaLog9Ak4StbU4LvjbPEuOsM=;
        b=BhMBI12v4AquEAdSomWbB+zkYdHtP53CzBqCOgjNKCknR8LLWTBMgt6BO4LQEssVuc
         WlUwcTSmOlVCCIBg+tzuj3VSQ2a8a0Rvt0X5sf50otSXEQt5KzLtsNyAEjfc81Y5vjTG
         iBbgtDE61derbbFMHTJ8AZrmsNqNwzbNuDETzlCQkj/OayRSQ3UixMTOPafK6lAEYgcT
         0Qloawg+c9hO9Qo3lYLljKhCWV4kinKwB5geyfLNg98d76gEq0bhiTxnElcBmXMIOXNC
         9mLyq1/CJxRiQid7JUp5lUhAe/LsDuo2vDxGCXGxOrNE/NKw0pKgl/4T624EAo7M5e3K
         gTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792276506; x=1792881306;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eMD/z5ouOPSSIXAXetxHaLog9Ak4StbU4LvjbPEuOsM=;
        b=arYMDCL1IasviqrCa9+GYsbQ0nj9GU/l4gTmCR3Fy0T3UsH6F+68h0kQ1zHdZQ7Bhj
         Bqa6Ihq1G+8gwRI+Ros+jUbe1Q8xQM/KgzXAS942kG3P7283BdzbpXd10lgwjL8dIENT
         vxIw3rp6eDrKPdbS351WZBFGX66N+4HCXHCHUzx4fjKafMTvGG5OvHEqh7fyHe4C7xDr
         0mdabruHiIdpVbvnyT6DZ3I/sPzxBGsHz8fKkt5TtbZ6Q30ZMvByMc9uHWbEYSFxotd+
         VnK+JXO/rk2qJvVVKHSYL3iYdx6Vbl4x/Uvp/h3cTahMnQFOIPxM8qw9/gLBAzOKyy7L
         Q1Ww==
X-Forwarded-Encrypted: i=1; AKwUvByY/6fcG+cfAgRkMVO0psm4afqVWrn8kaD5/NqWpKf2TILxmZMHHkLdk9EanWDcOXLNAW5ySC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuN1AkjGVihJ5H4qy6ZCcTZxvolaqSiBYd7v0QdZQJOpCYnN2b
	feSoEl9IwAX9N6B82hLduKtphjqeMmKTQNr9zK85JZ3izaSnSCUX3ylfKqroIJh6uhM=
X-Gm-Gg: AYBFou0gFt/vraNpwxzg5Ip9ESgB0dhg9eaegxzER8FiRhpGgbLYQnuiitce6B77nvb
	oaATd/YgimxlW/u+EgU2zlPQb/Lq1gfurvBoDoIU+x8GzCcd6+3j7k0e16F+hA+X5/6qpu9lFRB
	/9yHSCjo73HZ0AH+7h4X+o3xkukd4qWSXy3EArC1jBoCh2DY30BGatR/njHeUY4BTA7U87fE0fy
	R9QVyma8cxYDQpbWgeT7OH4HivMLYQnqsF2DROJwtJ16BEuyc9dodQaF5ItEkCzUFU+GOtBxq9T
	9zhQHVRxgSHLqWJyNSK7oHXtoJ6q1gnEvEWUSVF0xstxvrJMHwfbd6vc918Ag0zYSm/sfm3HdTb
	Fvb/XInwIK9Wd/FtB44Om0s8fT82c+fVAorZoZVYoIKBXyGZbqIZLLwQd21PjmT8T7PSNGCNchz
	FRqrlRGK6rs6JlfWQXHoV96hKwmPEZSrLmZpsEatenO681FKyPwdG5Gr8BD11/QuXEAWTr3LP1Q
	Z7oV4Vj1Z5717SybTR+wj6q92Yl3KYzxsFZE5uXeyTN0Nnqn73m8GWFsjn0ymA2jZ68TeQars48
	4wGLb9ECJiXK89eUHarl/tGWEEYbgEmmvyGj+PqIw77dYjA5atsZsrEsxQeeNLAy
X-Received: by 2002:a05:690e:1188:b0:679:9a92:5d59 with SMTP id 956f58d0204a3-679ca4d0a3fmr887670d50.13.1792276506309;
        Sat, 17 Oct 2026 15:35:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:73b8:7067:c087:bc97? ([2600:1700:6476:1430:73b8:7067:c087:bc97])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1f0784bsm2583995d50.19.2026.10.17.15.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 15:35:05 -0700 (PDT)
Message-ID: <9b478e124201b9e3fb3292f900f2ff287b31ad40.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Sat, 17 Oct 2026 15:35:01 -0700
In-Reply-To: <20261016023125.2271361-1-hengyul@cs.unc.edu>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu>
	 <45b692cfda51e3b10caa27ae51609edc34efb0d0.camel@dubeyko.com>
	 <20261016023125.2271361-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Hengyu,

On Thu, 2026-10-15 at 22:31 -0400, Hengyu Liang wrote:
> Hi Slava,
>=20
> On Thu, Oct 15, 2026 at 12:58:14PM -0700, Viacheslav Dubeyko wrote:
> > (1) The goal of hfs_correct_next_unused_CNID() was to fix the
> > volume
> > corruption issue. Have you run hfs.fsck tool to check that volume
> > is
> > valid (not corrupted) after your fix?
>=20
> Thanks for pointing this out. I have now run the additional checks on
> v7.3-rc6 with this patch, using fsck.hfs 540.1-Linux:
>=20
> - All 14 normal-volume images from the original tests passed
> =C2=A0 fsck.hfs -fn after unmount. This includes the reproducer, CNID
> holes,
> =C2=A0 missing optional file threads, concurrent operations, and reordere=
d
> =C2=A0 leaf node numbers. The checker did not modify the images.
>=20
> > (2) Have you run xfstests (especially, generic/736) with your fix?
> > Because, the patch had goal to fix the generic/736 failure:
>=20
> - On a freshly formatted 64 MiB HFS volume, I ran:
>=20
> =C2=A0=C2=A0=C2=A0 ./check -i 10 generic/736
>=20
> =C2=A0 All 10 iterations passed, including the filesystem checks after
> each
> =C2=A0 iteration, with FSCK_OPTIONS=3D"-fn". A separate fsck.hfs -fn afte=
r
> =C2=A0 the run also passed. There was no "invalid MDB drNxtCNID" error.
> =C2=A0 The unpatched v7.3-rc6 kernel also passed these 10 iterations.
>=20
> - I repeated the minimal reproducer on a separate fresh volume. The
> =C2=A0 first creation of c failed with EEXIST without the patch and
> succeeded
> =C2=A0 with it. The surviving file's CNID and contents were unchanged, an=
d
> =C2=A0 the patched volume passed fsck.hfs -fn after unmount.

Sounds great! Let me take a look into the code.

>=20
> For completeness, I initially ran generic/736 on a 256 MiB HFS
> volume.
> The test body completed, but the final fsck reported:
>=20
> =C2=A0=C2=A0=C2=A0 Invalid map node linkage
> =C2=A0=C2=A0=C2=A0 (4, 2048)
>=20
> I reproduced the same failure on unpatched v7.3-rc6 with the same
> volume
> size and tools. The catalog had 6129 nodes, while its header map and
> single map node covered only 5984 nodes. I then used fresh 64 MiB
> volumes
> for the runs above; their filesystem checks passed without repair.

It looks that we have enough issues yet for the fix.

Thanks,
Slava.

>=20
> No KASAN report or kernel BUG/WARNING was observed during these runs.
>=20
> Thanks,
> Hengyu
